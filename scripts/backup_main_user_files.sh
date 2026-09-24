#!/bin/bash
set -Eeuo pipefail

usage() {
  echo "Backs up main user directories, files, and mobile backups to Veracrypt encrypted volume. The calling terminal must have the Full Disk Access permission. \`caffeinate\` is required to keep the system awake."
  echo "Usage: $0 [--keep-awake]"
}

while test $# != 0; do
  case "$1" in
  -h | --help)
    usage
    exit 0
    ;;
  --keep-awake)
    keep_awake=true
    ;;
  --)
    shift
    break
    ;;
  *)
    usage >&2
    exit 2
    ;;
  esac
  shift
done

if [[ $# -ne 0 ]]; then
  usage >&2
  exit 2
fi

user_directories=(
  "Library/Application Support/MobileSync"
  Desktop
  Documents
  Downloads
  Movies
  Music
  Pictures
  Videos
  "Virtual Machines.localized"
)
backup_volume_diskuuid="C9107440-03AB-42CE-894B-914A9FD8D84F"
keychain_item_name="ToshibaVeraCryptVolume"
mount_point="/Volumes/Toshiba"

red="\033[0;31m"
yellow="\033[0;33m"
blue="\033[0;34m"
no_color="\033[0m"
green="\033[0;32m"

print_msg() { echo -e "$(date) ${blue}$*${no_color}"; }
print_success() { echo -e "$(date) ${green}✅ $*${no_color}"; }
print_warning() { echo -e "$(date) ${yellow}$*${no_color}"; }
print_error() { echo -e "$(date) ${red}💀 $*${no_color}" >&2; }
err_exit() {
  print_error "$*"
  exit 1
}

# Prerequisites: macOS diskutil/plutil/security, jq, rsync 3.x, VeraCrypt;
# caffeinate is required only with --keep-awake. See README.md.
veracrypt_app="${VERACRYPT_BIN:-/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt}"
for tool in diskutil plutil security jq rsync awk; do
  command -v "$tool" >/dev/null || err_exit "Required tool not found: $tool"
done
[[ -x "$veracrypt_app" ]] || err_exit "VeraCrypt not found: $veracrypt_app"
rsync_help=$(rsync --help)
[[ "$rsync_help" == *--info* ]] || err_exit "rsync 3.x is required (install Homebrew rsync and put it on PATH)"

disk_info_xml=$(diskutil info -plist "$backup_volume_diskuuid") ||
  err_exit "Volume with DiskUUID $backup_volume_diskuuid not found. Is it connected?"
disk_info_json=$(printf '%s\n' "$disk_info_xml" | plutil -convert json -o - -- -)
device_identifier=$(printf '%s\n' "$disk_info_json" | jq -er '.DeviceIdentifier | select(type == "string" and test("^disk[0-9]+(s[0-9]+)*$"))') ||
  err_exit "Invalid DeviceIdentifier for $backup_volume_diskuuid"
volume="/dev/r$device_identifier"

# VeraCrypt's short listing is: slot, encrypted device, virtual device, mount point.
# These configured device/mount paths contain no spaces; match whole fields.
volume_record() {
  local listing
  listing=$("$veracrypt_app" --text --list) || return 1
  printf '%s\n' "$listing" | awk -v device="$volume" -v block_device="/dev/$device_identifier" '$2 == device || $2 == block_device { print }'
}
verify_mount() {
  local record mount_xml mount_json virtual_device
  record=$(volume_record) || return 1
  [[ $(printf '%s\n' "$record" | awk -v destination="$mount_point" 'NF == 4 && $4 == destination { n++ } END { print n+0 }') == 1 ]] || return 1
  virtual_device=$(printf '%s\n' "$record" | awk '{ print $3 }')
  [[ "$virtual_device" == /dev/disk* ]] || return 1
  mount_xml=$(diskutil info -plist "$mount_point") || return 1
  mount_json=$(printf '%s\n' "$mount_xml" | plutil -convert json -o - -- -) || return 1
  printf '%s\n' "$mount_json" | jq -e --arg path "$mount_point" --arg device "$virtual_device" '.Mounted == true and .MountPoint == $path and .DeviceNode == $device' >/dev/null || return 1
  [[ -d "$mount_point" && ! -L "$mount_point" ]]
}

awake_pid=''
mounted_by_script=false
cleanup() {
  local status=$?
  trap - EXIT INT TERM
  # Never dismount a volume that was already mounted before this invocation.
  if [[ "$mounted_by_script" == true ]]; then
    if verify_mount; then
      "$veracrypt_app" --text --dismount "$mount_point" || {
        print_error "Dismount failed; volume may still be mounted"
        status=1
      }
    else
      print_warning "Mount identity could not be verified during cleanup; check VeraCrypt manually."
      status=1
    fi
  fi
  if [[ -n "$awake_pid" ]]; then
    kill "$awake_pid" 2>/dev/null || true
    wait "$awake_pid" 2>/dev/null || true
  fi
  exit "$status"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

if [[ -n "${keep_awake:-}" ]]; then
  command -v caffeinate >/dev/null || err_exit "Required tool not found: caffeinate"
  caffeinate -d -i -m -s -u &
  awake_pid=$!
  sleep 1
  kill -0 "$awake_pid" || err_exit "Awake process failed"
fi

# --list can fail when no volumes are mounted. No writes are permitted until
# both VeraCrypt and diskutil confirm the destination after the mount attempt.
record=$(volume_record) || record=''
if [[ -z "$record" ]]; then
  print_msg "Retrieving volume password from keychain..."
  volume_password=$(security find-generic-password -s "$keychain_item_name" -w) || err_exit "Password for $keychain_item_name not found"
  print_msg "Mounting volume..."
  "$veracrypt_app" --text --mount "$volume" "$mount_point" \
    --password "$volume_password" --pim 0 --keyfiles "" --protect-hidden no || err_exit "Mount volume failed; check VeraCrypt for any partial mount"
  mounted_by_script=true
  unset volume_password
fi
verify_mount || err_exit "Expected VeraCrypt volume is not mounted at $mount_point; refusing backup"

failures=0
for user_directory in "${user_directories[@]}"; do
  directory="$HOME/$user_directory"
  backup_directory="$mount_point/$user_directory"
  if [[ ! -d "$directory" ]]; then
    print_error "Source directory missing: $directory; destination left untouched"
    failures=$((failures + 1))
    continue
  fi
  verify_mount || err_exit "Backup mount disappeared or changed; refusing further writes"
  # Reject symlinked destination components (including intermediate Library paths).
  component="$mount_point"
  IFS=/ read -r -a parts <<<"$user_directory"
  for part in "${parts[@]}"; do
    component="$component/$part"
    [[ ! -L "$component" ]] || err_exit "Destination contains a symlink: $component"
  done
  if ! mkdir -p "$backup_directory"; then
    print_error "Cannot create $backup_directory"
    failures=$((failures + 1))
    continue
  fi
  print_msg "Backing up $user_directory..."
  if rsync --archive --no-perms --no-group --no-owner --inplace --sparse \
    --delete --info=progress2 --no-inc-recursive --human-readable \
    --exclude ".DS_Store" --exclude ".Trashes*" --exclude ".fseventsd" \
    "$directory/" "$backup_directory/"; then
    print_success "Backed up $user_directory"
  else
    print_error "Backup of $user_directory failed. Check Full Disk Access and rsync output."
    failures=$((failures + 1))
  fi
done

print_warning "NOTE: skipping iCloud Drive (Notes) and ~/source. Back them up manually."
if [[ -t 0 ]]; then
  read -r -p "Press Enter after any manual backups to finish" || true
fi
[[ "$failures" == 0 ]] || err_exit "$failures directory backup(s) failed"
print_success "All configured directories backed up"

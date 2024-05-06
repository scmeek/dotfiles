#!/bin/bash
set -Eeuo pipefail
#dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

usage() {
	echo "Backs up main user directories, files, and mobile backups to Veracrypt encrypted volume. The calling terminal must have the Full Disk Access permission. \`caffeinate\` is required to keep the system awake."
	echo "Usage: $0 [--keep-awake]"
}

while test $# != 0; do
	case "$1" in
	-h | --help)
		usage
		;;
	--keep-awake)
		keep_awake=true
		;;
	--)
		shift
		break
		;;
	*)
		usage
		;;
	esac
	shift
done

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

veracrypt_app="/Applications/VeraCrypt.app/contents/MacOS/VeraCrypt"
disk_info_xml=$(diskutil info -plist "${backup_volume_diskuuid}") ||
	err_exit "Volume with DiskUUID ${backup_volume_diskuuid} not found." \
		"Is it connected?"
disk_info_json=$(echo "${disk_info_xml}" | plutil -convert json -o - -- -)
device_identifier=$(echo "${disk_info_json}" | jq -r '.DeviceIdentifier') ||
	err_exit "DeviceIdentifier for volume with DiskUUID" \
		"${backup_volume_diskuuid} not found."
volume="/dev/r${device_identifier}"

mounted_directory() {
	# shellcheck disable=SC2005
	echo "$("${veracrypt_app}" --text -l 2>/dev/null |
		grep "${volume}" |
		awk '{print $2}')"
}

# Stay awake
if [[ -n "${keep_awake:-}" ]]; then
	print_msg "Keeping system awake with \`caffeinate\`..."

	# d: display; i: idle; m: disk; s: system; u: user is active
	caffeinate -d -i -m -s -u &
	awake_pid=$!

	sleep 1

	if kill -0 ${awake_pid}; then
		print_success "System will be kept awake during backup"
	else
		err_exit "Awake process failed"
	fi

fi

# Mount volume
mounted_directory=$(mounted_directory)
if [[ -z "${mounted_directory}" ]]; then
	print_msg "Retrieving volume password from keychain..."
	volume_password=$(security find-generic-password -s "${keychain_item_name}" -w) && print_success "Password retrieved" ||
		err_exit "Password for ${keychain_item_name} not found"

	print_msg "Mounting volume..."
	print_msg "If the next step appears to hang, the terminal may need access to Network Devices. Attempt pressing \"Enter\" to receive a prompt to enter Administrator password to mount the device."
	"${veracrypt_app}" --text \
		--mount "${volume}" "${mount_point}" \
		--password "${volume_password}" \
		--pim 0 \
		--keyfiles "" \
		--protect-hidden no &&
		print_success "Volume mounted" ||
		err_exit "Mount volume failed"
else
	print_msg "Volume already mounted"
fi

# Backup directories
for user_directory in "${user_directories[@]}"; do
	print_msg "Backing up ${user_directory}..."
	directory="${HOME}/${user_directory}"
	backup_directory="${mount_point}/${user_directory}"

	mkdir -p "${backup_directory}"

	rsync \
		--archive \
		--no-perms \
		--no-group \
		--no-owner \
		--inplace \
		--sparse \
		--delete \
		--info=progress2 \
		--no-inc-recursive \
		--human-readable \
		--exclude ".DS_Store" \
		--exclude ".Trashes*" \
		--exclude ".fseventsd" \
		"${directory}/" "${backup_directory}/" && print_success "Backed up ${user_directory}" || print_error "Back up of ${user_directory} failed. Does the calling terminal have Full Disk Access permisision?"
done

# Dismount volume
mounted_directory=$(mounted_directory)
if [[ -n "${mounted_directory}" ]]; then
	print_msg "Dismounting volume..."

	"${veracrypt_app}" --text --dismount "${mounted_directory}" &&
		print_success "Volume dismounted" ||
		print_error "Dismount volume failed"
fi

if [[ -n "${keep_awake:-}" && -n "${awake_pid}" ]]; then
	print_msg "Killing awake process..."
	kill "${awake_pid}" &&
		print_success "Awake process killed" ||
		err_exit "Kill awake process failed"
fi

print_warning "NOTE: skipping iCloud Drive (Notes). Be sure to do so manually."
print_warning "NOTE: skipping ~/source. Be sure to do so manually."

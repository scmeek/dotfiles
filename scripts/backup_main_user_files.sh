#!/bin/bash
set -Eeuo pipefail
#dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)

usage() {
	echo "Backs up main user directories, files, and mobile backups to Veracrypt encrypted volume. The calling terminal must have the Full Disk Access permission."
	echo "Usage: $0"
}

if [[ $# -ne 0 ]]; then
	usage
	exit 1
fi

user_directories=(
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

err_exit() {
	echo -e "${red}💀 $*${no_color}" >&2
	exit 1
}
print_msg() { echo -e "${blue}$*${no_color}"; }
print_warning() { echo -e "${yellow}$*${no_color}"; }
success() { echo -e "${green}✅ $*${no_color}"; }

print_warning "NOTE: skipping \"Library/Application Support/MobileSync\". Be sure to do so manually."
print_warning "NOTE: skipping iCloud Drive (Notes). Be sure to do so manually."

print_warning "TODO: Add option to stay awake while executing."

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

echo ""
print_msg "$(date)"
print_msg "-----------------------"

# Mount volume
mounted_directory=$(mounted_directory)
if [[ -z "${mounted_directory}" ]]; then
	print_msg "Retrieving volume password from keychain"
	volume_password=$(security find-generic-password -s "${keychain_item_name}" -w) ||
		err_exit "Failed to find password for ${keychain_item_name}"

	print_msg "Mounting volume"
	print_msg "If the next step appears to hang, the terminal may need access to Network Devices. Attempt pressing \"Enter\" to receive a prompt to enter Administrator password to mount the device."
	"${veracrypt_app}" --text \
		--mount "${volume}" "${mount_point}" \
		--password "${volume_password}" \
		--pim 0 \
		--keyfiles "" \
		--protect-hidden no || err_exit "Volume failed to mount"

	print_msg "Volume mounted"
else
	print_msg "Volume already mounted"
fi

# Backup directories
for user_directory in "${user_directories[@]}"; do
	print_msg "Backing up ${user_directory} ($(date))"
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
		"${directory}/" "${backup_directory}/"
	success "Backed up ${user_directory} ($(date))"
done

# Dismount volume
mounted_directory=$(mounted_directory)
if [[ -n "${mounted_directory}" ]]; then
	print_msg "Dismounting volume"

	"${veracrypt_app}" --text \
		--dismount "${mounted_directory}" ||
		err_exit "Volume failed to dismount"

	print_msg "Volume dismounted"
fi

print_warning "NOTE: skipped \"Library/Application Support/MobileSync\". Be sure to do so manually."

#!/bin/bash
#
# Sync a git remote with remote

set -euo pipefail  # exit on error, error on unset vars, don't mask errors

usage()
{
   echo ""
   echo "Usage: $0 SCHEDULE COMMAND"
   echo -e "\tSCHEDULE: The cron schedule in [min hr day_of_month month day_of_week]"
   echo -e "\tCOMMAND: The command to run"
   exit 1
}

if [[ $# -ne 2 ]]; then
  usage
fi

SCHEDULE="${1}"
COMMAND="${2/#\~/$HOME}"  # Bash parameter expansion

BLUE="\033[0;34m"
NO_COLOR="\033[0m"
GREEN="\033[0;32m"
print_msg() { echo -e "${BLUE}$*${NO_COLOR}"; }
success() { echo -e "${GREEN}✅ $*${NO_COLOR}"; }

cronjob="${SCHEDULE} ${COMMAND}"

if crontab -l | grep -F "${COMMAND}"; then
  print_msg "Cron job already exists"
  exit 0
fi

( crontab -l ; echo "$cronjob" ) | crontab -

success "Cron job added"
exit 0


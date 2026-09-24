#!/bin/bash
set -euo pipefail

if [[ $# -ne 2 || -z "$1" || -z "$2" ]]; then
  printf 'Usage: %s SCHEDULE COMMAND\n' "$0" >&2
  exit 2
fi
schedule=$1
command=${2/#\~/$HOME}
if [[ "$schedule$command" == *$'\n'* || "$schedule$command" == *$'\r'* ]]; then
  printf 'Schedule and command must each be a single line.\n' >&2
  exit 2
fi
cronjob="$schedule $command"
work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# A missing table is expected; permission and other errors must not replace it.
if ! LC_ALL=C crontab -l >"$work_dir/current" 2>"$work_dir/error"; then
  if ! grep -Eq '^crontab: no crontab for .+$' "$work_dir/error"; then
    cat "$work_dir/error" >&2
    exit 1
  fi
  : >"$work_dir/current"
fi
if grep -Fxq -- "$cronjob" "$work_dir/current"; then
  printf 'Cron job already exists\n'
  exit 0
fi
# awk preserves existing lines and supplies a missing final newline.
awk '{print}' "$work_dir/current" >"$work_dir/new"
printf '%s\n' "$cronjob" >>"$work_dir/new"
crontab "$work_dir/new"
printf '✅ Cron job added\n'

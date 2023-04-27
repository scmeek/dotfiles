#!/bin/bash
#
# Sync a git remote with remote

set -Eeuo pipefail # exit on error, error on unset vars, don't mask errors

err_exit() {
	echo -e "💀 $*" >&2
	exit 1
}

usage() {
	echo "Sync a git repo with remote"
	echo "Usage: $0 GIT_DIR"
	echo -e "\tGIT_DIR: The git directory to sync"
	exit 1
}

if [[ $# -ne 1 ]]; then
	usage
fi

echo "-----------------------"
date

GIT_DIR="${1/#\~/$HOME}" # Bash parameter expansion

[[ -d "${GIT_DIR}" ]] || err_exit "${GIT_DIR} does not exist"

cd "${GIT_DIR}"

if [[ ! "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
	err_exit "${GIT_DIR} is not a git repo"
fi

# stash changes
git add .
CHANGED_FILES=$(git diff --no-ext-diff HEAD)
git restore --staged .

if [[ "${CHANGED_FILES}" ]]; then
	git stash --include-untracked
fi

# get latest
git pull --rebase || err_exit "Unable to pull repo from remote"

# unstash changes
if [[ "${CHANGED_FILES}" ]]; then
	git stash pop

	git add .

	git commit -m "Automated update" || err_exit "Unable to push repo to remote"

	git push
fi

echo "✅ Synced ${GIT_DIR}"
echo ""
exit 0

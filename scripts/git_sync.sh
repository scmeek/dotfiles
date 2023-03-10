#!/bin/bash
#
# Sync a git remote with remote

set -euo pipefail  # exit on error, error on unset vars, don't mask errors

usage()
{
   echo ""
   echo "Usage: $0 GIT_DIR"
   echo -e "\tGIT_DIR: The git directory to sync"
   exit 1
}

if [[ $# -lt 1 ]]; then
	 usage
fi

GIT_DIR="${1/#\~/$HOME}"  # Bash parameter expansion

RED="\033[0;31m"
NO_COLOR="\033[0m"
GREEN="\033[0;32m"
err_exit() { echo -e "${RED}💀 $*${NO_COLOR}" >&2; exit 1; }
success() { echo -e "${GREEN}✅ $*${NO_COLOR}"; }

[[ -z "${GIT_DIR}" ]] && err_exit ""

[[ ! -d "${GIT_DIR}" ]] && err_exit "${GIT_DIR} does not exist"

cd "${GIT_DIR}"

if [[ ! "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
	err_exit "${GIT_DIR} is not a git repo"
fi

# stash changes
git add .
CHANGED_FILES=$(git diff HEAD)
git restore --staged .

if [[ "${CHANGED_FILES}" ]]; then
   git stash --include-untracked
fi

# get latest
git pull --rebase

# unstash changes
if [[ "${CHANGED_FILES}" ]]; then
   git stash pop
fi

git add .

git commit -m "Automated update"

git push

success "Synced ${GIT_DIR}"


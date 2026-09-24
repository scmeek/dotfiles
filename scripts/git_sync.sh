#!/bin/bash
# Rebase onto the configured upstream and push commits, preserving local edits.
set -Eeuo pipefail

err_exit() {
  printf 'git_sync: %s\n' "$*" >&2
  exit 1
}
if [[ $# -ne 1 ]]; then
  printf 'Usage: %s GIT_DIR\n' "$0" >&2
  exit 2
fi
repo=${1/#\~/$HOME}
cd "$repo" || err_exit "$repo does not exist"
[[ $(git rev-parse --is-inside-work-tree 2>/dev/null) == true ]] || err_exit "$repo is not a working tree"
cd "$(git rev-parse --show-toplevel)"
git symbolic-ref -q HEAD >/dev/null || err_exit 'Detached HEAD; check out a branch first'
git rev-parse --verify HEAD >/dev/null || err_exit 'Create an initial commit first'
upstream=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}') || err_exit 'Configure an upstream branch first'
for state in rebase-merge rebase-apply MERGE_HEAD CHERRY_PICK_HEAD REVERT_HEAD; do
  [[ ! -e $(git rev-parse --git-path "$state") ]] || err_exit 'Finish the existing merge/rebase/cherry-pick/revert first'
done
[[ -z $(git ls-files --unmerged) ]] || err_exit 'Resolve existing conflicts first'

branch=$(git symbolic-ref --short HEAD)
remote=$(git config --get "branch.$branch.remote")
remote_ref=$(git config --get "branch.$branch.merge")
[[ "$remote" != '.' ]] || err_exit 'Upstream is a local branch; refusing to push into this repository'

stash_oid=''
stash_restored=false
report_saved_edits() {
  local status=$?
  if [[ -n "$stash_oid" ]]; then
    printf 'Local edits remain saved in stash commit %s.\n' "$stash_oid" >&2
    if [[ "$stash_restored" == true ]]; then
      printf 'Edits are already restored; remove the saved stash after reviewing it.\n' >&2
    else
      printf 'After resolving/aborting the rebase, restore on a clean working tree with:\n  git stash apply --index %s\n' "$stash_oid" >&2
    fi
  fi
  exit "$status"
}
trap report_saved_edits EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

# Status reads the index without staging or unstaging any files.
status=$(git status --porcelain --untracked-files=normal) || err_exit "Unable to inspect working tree"
if [[ -n "$status" ]]; then
  previous_stash=$(git rev-parse -q --verify refs/stash || true)
  if ! git stash push --include-untracked -m 'git_sync: local edits'; then
    new_stash=$(git rev-parse -q --verify refs/stash || true)
    if [[ -n "$new_stash" && "$new_stash" != "$previous_stash" ]]; then
      stash_oid=$new_stash
    fi
    err_exit 'Unable to stash local edits; inspect the working tree before recovery'
  fi
  new_stash=$(git rev-parse --verify refs/stash)
  [[ "$new_stash" != "$previous_stash" ]] || err_exit 'No new stash created; refusing to pull'
  stash_oid=$new_stash
  status=$(git status --porcelain --untracked-files=normal) || err_exit 'Unable to inspect working tree after stashing'
  [[ -z "$status" ]] || err_exit 'Working tree still has changes (possibly in submodules); refusing to pull'
fi

# Override autostash so this script owns restoration and preserves the index.
git -c pull.autostash=false -c rebase.autoStash=false pull --rebase || err_exit 'Pull/rebase failed; resolve or abort it before restoring saved edits'
if [[ -n "$stash_oid" ]]; then
  git stash apply --index "$stash_oid" || err_exit 'Restoring local edits conflicted; stash retained, nothing pushed'
  stash_restored=true
  # Drop only our own stash, and only after successful restoration.
  if [[ $(git rev-parse -q --verify refs/stash) != "$stash_oid" ]]; then
    err_exit 'Stash stack changed; edits restored, saved stash retained, nothing pushed'
  fi
  git stash drop 'stash@{0}' || err_exit 'Edits restored, but could not remove saved stash'
  stash_oid=''
fi

# Push to the same branch we pulled, independent of push.default/pushRemote.
ahead=$(git rev-list --count "$upstream..HEAD") || err_exit "Unable to compare with upstream"
if [[ "$ahead" -gt 0 ]]; then
  git push -- "$remote" "HEAD:$remote_ref" || err_exit 'Push failed; commits and restored local edits remain local'
fi
printf '✅ Synced %s; local edits left uncommitted\n' "$repo"

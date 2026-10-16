rgf() {
  rg --files $2 | rg $1
}

rgfa() {
  rg --files --no-ignore-vcs | rg $1
}

attempt_activate_venv() {
  local -a env_paths=("./.venv" "./venv" "${additional_env_paths[@]}")
  local env_path activate_file_candidate

  for env_path in "${env_paths[@]}"; do
    [[ -z "${env_path}" ]] && continue

    activate_file_candidate="${env_path}/bin/activate"

    if [[ -f "${activate_file_candidate}" ]]; then
      # shellcheck disable=SC1091
      source "${activate_file_candidate}"
    fi
  done
}

# Auto activate virtualenv on cd and show dir files
# https://stackoverflow.com/a/56309561
cd_activate_ls() {
  # z is a cd replacement
  if (($+functions[z])); then
    if ! z "$@"; then
      return
    fi
  elif ! builtin cd -- "$@"; then
    return
  fi

  if [[ -z "${VIRTUAL_ENV}" ]]; then
    attempt_activate_venv
  else
    # If not in subdirectory of VIRTUAL_ENV, deactivate and attempt activation
    # Ignore path casing
    local virtual_env_parent_dir="$(dirname "${VIRTUAL_ENV}")"
    if [[ "${PWD:u}"/ != "${virtual_env_parent_dir:u}"/* ]]; then
      (($+functions[deactivate])) && deactivate
      attempt_activate_venv
    fi
  fi

  ls
}

tempe() {
  cd "$(mktemp -d)"
  chmod -R 0700 .
  if [[ $# -eq 1 ]]; then
    \mkdir -p "$1"
    cd "$1"
    chmod -R 0700 .
  fi
}

# https://gist.github.com/GNOMES/6bf65926648e260d8023aebb9ede9573
# Jump backwards to a named directory in the current path.
dc() {
  local target="$1"
  if [[ -z "$target" ]]; then
    echo "Usage: dc <directory>"
    return 1
  fi

  local dest="${PWD%/$target/*}/$target"
  if [[ "$dest" == "$PWD" || ! -d "$dest" ]]; then
    echo "Directory not found in current path: $target"
    return 1
  fi

  builtin cd -- "$dest"
}

# Complete directory names from the current path.
_dc() {
  local -a dirs
  dirs=("${(@s:/:)PWD}")

  # Remove empty element caused by leading /
  dirs=("${(@)dirs:#}")

  _describe 'parent directory' dirs
}

compdef _dc dc

git_changed_most() {
  git log --format=format: --name-only --since="1 year ago" | sort | uniq -c | sort -nr | head -20
}

git_who_built() {
  git shortlog -sn --no-merges
}

git_where_bugs() {
  git log -i -E --grep="fix|bug|broken" --name-only --format='' | sort | uniq -c | sort -nr | head -20
}

git_pace() {
  git log --format='%ad' --date=format:'%Y-%m' | sort | uniq -c
}

git_firefight() {
  git log --oneline --since="1 year ago" | grep -iE 'revert|hotfix|emergency|rollback'
}

# Yazi
# https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
# Change the current working directory when exiting
# `q`` to quit, `Q` to quit without changing CWD
function y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
  command rm -f -- "$tmp"
}

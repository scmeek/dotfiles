#zmodload zsh/zprof  # Profiling, use with `zprof` command

: "${HOME:?HOME must be set}"

: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
export XDG_DATA_HOME XDG_CONFIG_HOME XDG_STATE_HOME XDG_CACHE_HOME

typeset -U path PATH

#--------------------------------------------------------------------------
# Environment variables
#--------------------------------------------------------------------------

export SM_XDG_BIN_HOME="${SM_XDG_BIN_HOME:-${HOME}/.local/bin}"             # Prefixed since not XDG standard var
export SM_XDG_BIN_BIN_HOME="${SM_XDG_BIN_BIN_HOME:-${SM_XDG_BIN_HOME}/bin}" # Nested for dotfiles bin

export AWS_SHARED_CREDENTIALS_FILE="${XDG_CONFIG_HOME}"/aws/credentials
export AWS_CONFIG_FILE="${XDG_CONFIG_HOME}"/aws/config
export CARGO_HOME="${XDG_DATA_HOME}"/cargo
export DOCKER_CONFIG="${XDG_CONFIG_HOME}"/docker
export GNUPGHOME="${XDG_DATA_HOME}"/gnupg
export GRADLE_USER_HOME="${XDG_DATA_HOME}"/gradle
export HISTFILE="${XDG_STATE_HOME}"/zsh/history
export LESSHISTFILE="${XDG_CACHE_HOME}"/less/history
export TERMINFO="${XDG_DATA_HOME}"/terminfo
#export TERMINFO_DIRS="${XDG_DATA_HOME}"/terminfo # Set by wezterm
export NODE_REPL_HISTORY="${XDG_DATA_HOME}"/node_repl_history
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}"/npm/npmrc
export ZSH="${XDG_DATA_HOME}"/oh-my-zsh
export ZSH_COMPDUMP="${XDG_CACHE_HOME}/oh-my-zsh/.zcompdump-${HOST}"
export PSQL_HISTORY="${XDG_DATA_HOME}"/psql_history
export PYENV_ROOT="${XDG_DATA_HOME}"/pyenv
export PYTHONSTARTUP="${XDG_CONFIG_HOME}"/python/pythonrc
export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME}"/ripgrep/ripgreprc
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}"/starship/starship.toml
export STARSHIP_CACHE="${XDG_DATA_HOME}"/starship/cache

export ZSHRC_LOCAL_FILE="${ZSHRC_LOCAL_FILE:-${HOME}/.zshrc_local}"

#--------------------------------------------------------------------------
# General config
#--------------------------------------------------------------------------

path=("${SM_XDG_BIN_HOME}" "${SM_XDG_BIN_BIN_HOME}" $path)
path=("${DOCKER_CONFIG}" $path)
if command -v npm >/dev/null 2>&1; then
  npm_prefix="$(npm config get prefix 2>/dev/null || true)"
  [[ -n "${npm_prefix}" ]] && path=("${npm_prefix}/bin" $path)
fi

export HYPHEN_INSENSITIVE="true" # Used in completion
export COMPLETION_WAITING_DOTS="true"
export HIST_STAMPS="yyyy-mm-dd"

HISTSIZE=1000000
export SAVEHIST=${HISTSIZE}

setopt BANG_HIST          # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY   # Write the history file in the "start:elapsed;command" format
setopt INC_APPEND_HISTORY # Write to the history file immediately, not when the shell exists
setopt SHARE_HISTORY      # Share history between all sessions
setopt HIST_REDUCE_BLANKS # Remove superfluous blanks before recording entry

# Duplicates
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS

# Helps syntax highlighting for `bat` for man pages and help text
if command -v tput >/dev/null 2>&1 && [[ -t 1 ]]; then
  LESS_DISPLAY_SETTINGS=$(
    tput bold
    tput setaf 4
  )
  export LESS_TERMCAP_md="${LESS_DISPLAY_SETTINGS}" # blue
fi

export EDITOR=nvim
export VISUAL=nvim

#--------------------------------------------------------------------------
# Homebrew
#--------------------------------------------------------------------------

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ANALYTICS=1
#export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ENV_HINTS=1

brew_bin=""
for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew; do
  if [[ -x "${candidate}" ]]; then
    brew_bin="${candidate}"
    break
  fi
done
if [[ -z "${brew_bin}" ]] && command -v brew >/dev/null 2>&1; then
  brew_bin="$(command -v brew)"
fi

if [[ -n "${brew_bin}" ]]; then
  eval "$("${brew_bin}" shellenv)"
  typeset -U path PATH

  # This may be useful in select cases but generally should be avoided as
  # libraries likely need to be supplied by the system, rather than from here
  # (e.g. openssl)
  # export LD_LIBRARY_PATH="/home/linuxbrew/.linuxbrew/lib:$LD_LIBRARY_PATH"
fi

# Add Homebrew completions before loading Oh My Zsh.
if [[ -n "${brew_bin}" ]]; then
  fpath=("$("${brew_bin}" --prefix)/share/zsh/site-functions" $fpath)
fi

# Optional Homebrew integrations.
if [[ -n "${HOMEBREW_PREFIX:-}" ]]; then
  [[ -r "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] &&
    source "${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

#--------------------------------------------------------------------------
# Oh-my-zsh
#--------------------------------------------------------------------------

# Add optional Docker Desktop completions before Oh My Zsh initializes the
# completion system.
[[ -d "${HOME}/.docker/completions" ]] && fpath=("${HOME}/.docker/completions" $fpath)

# shellcheck disable=SC2034
plugins=()

# shellcheck disable=SC1091
if [[ -r "${ZSH}/oh-my-zsh.sh" ]]; then
  source "${ZSH}/oh-my-zsh.sh"
else
  # Keep completion available when Oh My Zsh is intentionally absent.
  autoload -Uz compinit
  mkdir -p "${XDG_CACHE_HOME}/zsh"
  compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"
fi

#--------------------------------------------------------------------------
# Completion
#--------------------------------------------------------------------------

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

# shellcheck disable=SC2296 disable=SC2086
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# shellcheck disable=SC2016
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# shellcheck disable=SC2034
if [[ -t 1 ]]; then
  export GPG_TTY="$(tty)"
fi

# GNU only ('dircolors')
#zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# Replacement ('coreutils' required)
if command -v gdircolors >/dev/null 2>&1; then
  zstyle ':completion:*' menu select=2 eval "$(gdircolors -b)"
fi

# shellcheck disable=SC1090
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load syntax highlighting after completion and other Zsh integrations.
if [[ -n "${HOMEBREW_PREFIX:-}" && -r "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  ((${+ZSH_HIGHLIGHT_STYLES})) || typeset -A ZSH_HIGHLIGHT_STYLES
  ZSH_HIGHLIGHT_STYLES[path]=none
  ZSH_HIGHLIGHT_STYLES[path_prefix]=none
fi

#--------------------------------------------------------------------------
# zoxide (smarter `cd`)
#--------------------------------------------------------------------------

# Must be after compinit call
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias brewsync="brew update && brew upgrade && brew cleanup && brew doctor && brew upgrade --cask wezterm@nightly --greedy-latest"
alias e="$VISUAL"
alias cd="cd_activate_ls"
alias cd..="cd .."
(($+functions[zi])) && alias cdi="zi"
alias ls='eza --across --group-directories-first'
alias ll='eza --long --group --header --changed --group-directories-first'
alias la='eza --long --group --header --all --changed --group-directories-first'
alias tree='eza --tree'
alias shred='shred -uvz'
alias gg='lazygit' # `gg` matches keymap in nvim
alias rmgitignored='git clean -dfX -f -f'

# shellcheck disable=SC2139
alias wget="wget --hsts-file=${XDG_DATA_HOME}/wget-hsts"

# Additional `bat` configuration
export MANPAGER="sh -c 'col -bx | bat --language=man'"
alias -g -- --help='--help 2>&1 | bat --language=help'
alias cat='bat --paging=never'

alias g="git"
alias gsip="git reset --soft HEAD~1; git commit --all --amend --no-edit" # gsip: "git, squash into parent"

alias doawake="caffeinate -dimsu &" # Prevent sleep (`caffeine` required)

alias p="python3"
alias sz="echo 'Sourcing \".zshrc\"...'; source "${HOME}"/.zshrc"
alias y="yazi"
alias ez='"${EDITOR}" "${HOME}"/.zshrc'

#--------------------------------------------------------------------------
# Custom functions
#--------------------------------------------------------------------------

# Search for filename in directory
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

#--------------------------------------------------------------------------
# Starship
#--------------------------------------------------------------------------

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# Status-aware horizontal rule after each command
precmd() {
  local exit_code=$?

  local line="${(l:$COLUMNS::⎯:)}"

  if [[ $exit_code -eq 0 ]]; then
    print -P "%F{green}${line}%f"
  else
    print -P "%F{red}${line}%f"
  fi
}

preexec() {
  _last_command="$1"
}

#--------------------------------------------------------------------------
# Environment-specific configuration
#--------------------------------------------------------------------------

[[ -r "${ZSHRC_LOCAL_FILE}" ]] && source "${ZSHRC_LOCAL_FILE}"

#--------------------------------------------------------------------------
# Startup
#--------------------------------------------------------------------------

# Prioritize system standard tools
path=(/usr/bin /bin /usr/sbin /sbin $path)

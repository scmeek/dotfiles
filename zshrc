#zmodload zsh/zprof  # Profiling, use with `zprof` command

fastfetch
echo ""

#--------------------------------------------------------------------------
# Environment variables
#--------------------------------------------------------------------------

export XDG_DATA_HOME="${HOME}"/.local/share
export XDG_CONFIG_HOME="${HOME}"/.config
export XDG_STATE_HOME="${HOME}"/.local/state
export XDG_CACHE_HOME="${HOME}"/.cache
export XDG_RUNTIME_DIR="/tmp/" # "/run/user/${UID}"  nvim plenary workaround

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
export RUSTUP_HOME="${XDG_DATA_HOME}"/rustup
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}"/starship/starship.toml
export STARSHIP_CACHE="${XDG_DATA_HOME}"/starship/cache

#--------------------------------------------------------------------------
# General config
#--------------------------------------------------------------------------

export HYPHEN_INSENSITIVE="true" # Used in completion
export COMPLETION_WAITING_DOTS="true"
export HIST_STAMPS="yyyy-mm-dd"

HISTSIZE=1000000
export SAVEHIST=${HISTSIZE}

setopt histignorealldups sharehistory

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
LESS_DISPLAY_SETTINGS=$(
	tput bold
	tput setaf 4
)
export LESS_TERMCAP_md=${LESS_DISPLAY_SETTINGS} # blue

export EDITOR=nvim
export VISUAL=nvim

#--------------------------------------------------------------------------
# Homebrew
#--------------------------------------------------------------------------

export HOMEBREW_NO_ENV_HINTS=1
eval "$(/usr/local/bin/brew shellenv)"

# Before oh-my-zsh
if type brew &>/dev/null; then
	FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

	autoload -Uz compinit
	compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"
fi

# shellcheck disable=SC1091 disable=SC2086
source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# shellcheck disable=SC1091 disable=SC2086
source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES[path]=none
export ZSH_HIGHLIGHT_STYLES[path_prefix]=none

#--------------------------------------------------------------------------
# Oh-my-zsh
#--------------------------------------------------------------------------

# shellcheck disable=SC2034
#plugins=()

# shellcheck disable=SC1091
source "${ZSH}"/oh-my-zsh.sh

#--------------------------------------------------------------------------
# Completion
#--------------------------------------------------------------------------

# Use modern completion system
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}"/zsh/zcompdump-"${ZSH_VERSION}"

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
export GPG_TTY=$(tty)
export PATH=/usr/local/sbin:"${PATH}"
export PATH=/usr/local/bin:"${PATH}"

# GNU only ('dircolors')
#zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# Replacement ('coreutils' required)
zstyle ':completion:*' menu select=2 eval "$(gdircolors -b)"

# shellcheck disable=SC1090
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#--------------------------------------------------------------------------
# zoxide (smarter `cd`)
#--------------------------------------------------------------------------

# Must be after compinit call
eval "$(zoxide init zsh)"

#--------------------------------------------------------------------------
# Python
#--------------------------------------------------------------------------

export PATH=/usr/local/opt/python/libexec/bin:$PATH

if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init -)"
fi

#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias brewsync="brew update && brew upgrade && brew cleanup && brew doctor"
alias e="$VISUAL"
alias cd="change_directory_auto_activate"
alias cdi="zi"
alias ls='eza --across'
alias ll='eza --long --group --header --changed'
alias la='eza --long --group --header --all --changed'
alias tree='eza --tree'
alias shred='shred -uvz'
alias lg='lazygit'

# shellcheck disable=SC2139
alias wget="wget --hsts-file=${XDG_DATA_HOME}/wget-hsts"

# Additional `bat` configuration
export MANPAGER="sh -c 'col -bx | bat --language=man'"
alias -g -- --help='--help 2>&1 | bat --language=help'
alias cat='bat --paging=never'

alias g="git"
alias gsip="git reset --soft HEAD~1; git commit --all --amend --no-edit" # gsip: "git, squash into parent"

alias doawake="caffeinate -dimsu &" # Prevent sleep (`caffeine` required)

eval "$(github-copilot-cli alias -- "$0")"

alias p="python3"
alias y="yazi"

#--------------------------------------------------------------------------
# Custom functions
#--------------------------------------------------------------------------

# Search for filename in directory
function rgf {
	rg --files $2 | rg $1
}

function rgfa {
  rg --files --no-ignore-vcs | rg $1
}

# Replace all in directory
function replace_all_in_directory() {
	if [[ $# -ne 3 ]]; then
		echo "Usage: $(basename "$0") <directory> <search-string> <replace-string>" >&2
		return 2
	fi
	read -p "Are you sure you want to replace all occurrences of $2 with $3 in $1? [y/N] " -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rg -l "$2" "$1" | xargs -n1 -I{} gsed -i "s/$2/$3/g" {}
		echo "Replaced all occurrences of $2 with $3 in $1."
	fi
}

function attempt_activate_venv() {
	declare -a env_paths=("./.venv" "${additional_env_paths[@]}")

	for env_path in "${env_paths[@]}"
	do
	  activate_file_candidate="${env_path}/bin/activate"
	  if [[ -f "${activate_file_candidate}" ]]; then
		  # shellcheck disable=SC1091
		  source "${activate_file_candidate}"
	  fi
	done
}

# Auto activate virtualenv
# https://stackoverflow.com/a/56309561
function change_directory_auto_activate() {
	# z is a cd replacement
	if ! z "$@" ; then
	  return
	fi

	if [[ -z "${VIRTUAL_ENV}" ]]; then
		attempt_activate_venv
	else
		# If not in subdirectory of VIRTUAL_ENV, deactivate and attempt activation
		# Ignore path casing
		virtual_env_parent_dir="$(dirname "${VIRTUAL_ENV}")"
		if [[ "${PWD:u}"/ != "${virtual_env_parent_dir:u}"/* ]]; then
			deactivate
			attempt_activate_venv
		fi
	fi
}

# Convert macOS screen recording to GIF
function to_gif() {
	if [[ $# -ne 1 ]]; then
		echo "Usage: $(basename "$0") <file-path>" >&2
		return 2
	fi

  ffmpeg -i "$1" -filter_complex "[0:v] fps=10,scale=1080:-2:flags=lanczos,split [a][b];[a] palettegen [p];[b][p] paletteuse" -y "${1%.*}.gif"
}

# Convert a markdown file to pdf of the same name
function md_to_pdf() {
  if [ $# -ne 1 ]; then
		echo "Usage: $(basename "$0") <markdown-file-name>" >&2
    return 1
  fi

  local input_file="$1"
  if [ ! -f "$input_file" ]; then
    echo "Error: File '$input_file' not found!"
    return 1
  fi

  local valid_extensions=("md" "mkd" "mdwn" "mdown" "mdtxt" "mdtext" "markdown" "text")
  local extension="${input_file##*.}"

  if [[ ! " ${valid_extensions[@]} " =~ " ${extension} " ]]; then
    echo "Error: Unsupported file extension '.${extension}'. Supported extensions are: ${valid_extensions[*]}"
    return 1
  fi

  local output_file="${input_file%.*}.pdf"
  pandoc -V geometry:margin=1in "$input_file" -o "$output_file"

  if [ $? -eq 0 ]; then
    echo "Conversion successful: '$output_file' created."
  else
    echo "Error: Conversion failed!"
    return 1
  fi
}

#--------------------------------------------------------------------------
# Environment-specific configuration
#--------------------------------------------------------------------------


#--------------------------------------------------------------------------
# Starship
#--------------------------------------------------------------------------

eval "$(starship init zsh)"

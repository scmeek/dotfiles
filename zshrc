#
#                 °#@@@@@#.       *@@@@@@*           °°°°°.
#               O@@@@o.°#@@#   .@@@@@@@@@@@.       °@@@@@@#
#              #@@@@o    @@@  *@@°  o@@@@@@@      *@@@@@@@
#              @@@@@@.  o@@#  @@     *@@@@@@@    o@@@@@@@@
#              @@@@@@@#      #@*     @@@@@@@@o  #@@@@@@@@.
#              @@@@@@@@@*    @@@.    @#@@@@@@@ @@o@@@@@@@
#               @@@@@@@@@#   *@@@@* @@ o@@@@@@@@ O@@@@@@°
#                *@@@@@@@@*   o@@*  @@  @@@@@@@  @@@@@@@
#        .@@@O     @@@@@@@@        @@*  @@@@@@  O@@@@@@o  #
#        @@@@o      @@@@@@@       #@@   #@@@@   @@@@@@@  @@
#       O@@@@       .@@@@@°*#   *@@@    *@@@    @@@@@@@ @@
#       °@@@@       O@@@@@ @@@@@@@@°     @@     o@@@@@@@@.
#        #@@@*     *@@@@O   @@@@@@.      #       *@@@@@o
#         °@@@@@#@@@@@o       °°
#            °o##Oo.
#
#      Personal .zshrc file of Sean Meek <sean@seanmeek.com>


#zmodload zsh/zprof  # Profiling, use with `zprof` command


#--------------------------------------------------------------------------
# Powerlevel10k (Top of file)
#--------------------------------------------------------------------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


#--------------------------------------------------------------------------
# Environment variables
#--------------------------------------------------------------------------

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export DOTFILES_PATH="$HOME/Documents/dotfiles"
export NOTES_PATH="$HOME/Documents/Notes"
export DEV_PATH="$HOME/Documents/Development"
eval "$(/usr/local/bin/brew shellenv)"


#--------------------------------------------------------------------------
# General config
#--------------------------------------------------------------------------

HYPHEN_INSENSITIVE="true"  # Used in completion
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

# Keep n lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000000
SAVEHIST=1000000
HISTFILE=~/.zsh_history

setopt histignorealldups sharehistory

setopt BANG_HIST  # Treat the '!' character specially during expansion
setopt EXTENDED_HISTORY  # Write the history file in the "start:elapsed;command" format
setopt INC_APPEND_HISTORY  # Write to the history file immediately, not when the shell exists
setopt SHARE_HISTORY  # Share history between all sessions
setopt HIST_REDUCE_BLANKS  # Remove superfluous blanks before recording entry

# Duplicates
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS  # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS


#--------------------------------------------------------------------------
# Homebrew
#--------------------------------------------------------------------------

# Before oh-my-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


#--------------------------------------------------------------------------
# Oh-my-zsh
#--------------------------------------------------------------------------

plugins=(
    colored-man-pages
)

source $ZSH/oh-my-zsh.sh


#--------------------------------------------------------------------------
# Vim
#--------------------------------------------------------------------------

# Set default editor to vim
export EDITOR=nvim
export VISUAL=nvim

bindkey -v  # vim mode


#--------------------------------------------------------------------------
# Completion
#--------------------------------------------------------------------------

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export GPG_TTY=$(tty)
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"

# GNU only ('dircolors')
#zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# Replacement ('coreutils' required)
zstyle ':completion:*' menu select=2 eval "$(gdircolors -b)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#--------------------------------------------------------------------------
# Python
#--------------------------------------------------------------------------

alias pip=pip3

if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi


#--------------------------------------------------------------------------
# Conda
#--------------------------------------------------------------------------

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/usr/local/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


#--------------------------------------------------------------------------
# Golang
#--------------------------------------------------------------------------

export GOPATH=$HOME/Documents/Development/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin


#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias vd='deactivate &> /dev/null || true'

alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias v="nvim"
alias diff="nvim -d"

alias cd="vd && cd "
alias cddotfiles="cd $DOTFILES_PATH"
alias cddf="cddotfiles"
alias cdnotes="cd $NOTES_PATH"
alias cddev="cd $DEV_PATH"
alias cdseanmeek="cd ${DEV_PATH}/seanmeek.com/"
alias cdsm="cdseanmeek"
alias cdttn="cd ${DEV_PATH}/TeeTimeNotify/"

alias gsip="git reset --soft HEAD~1; git commit --all --amend --no-edit"  # gsip: "git, squash into parent"
alias doawake="caffeinate -dimsu &"  # Prevent sleep ('caffeine' required)


#--------------------------------------------------------------------------
# Custom functions
#--------------------------------------------------------------------------

# Replace all in directory
repl() {
    if [[ $# -ne 3 ]]; then
        echo "usage: $0 <directory> <search-string> <replace-string>\n" >&2
        return 2
    fi
    read -p "Are you sure you want to replace all occurrences of $2 with $3 in $1? [y/N] " -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rg -l "$2" $1 | xargs -n1 -I{} gsed -i "s/$2/$3/g" {}
        echo 'Replaced all occurrences of $2 with $3 in $1.'
    fi
}

# Make directory and open
mkdircd() {
    if [[ $# -ne 1 ]]; then
        echo "usage: $0 <new-directory>\n" >&2
        return 2
    fi
    mkdir $1
    cd $1
}


#--------------------------------------------------------------------------
# Environment-specific configuration
#--------------------------------------------------------------------------


#--------------------------------------------------------------------------
# Powerlevel10k (Bottom of file)
#--------------------------------------------------------------------------

source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

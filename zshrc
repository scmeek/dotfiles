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
# Environment variables
#--------------------------------------------------------------------------

export ZSH="/Users/sean/.oh-my-zsh"
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
export DOTFILES_PATH="$HOME/Documents/dotfiles"
export NOTES_PATH="$HOME/Documents/Notes"


#--------------------------------------------------------------------------
# Startup
#--------------------------------------------------------------------------

# First iterm window, start tmux
if [[ $TERM_PROGRAM != "tmux" ]]; then
    if [[ $ITERM_SESSION_ID =~ w0t0p0* ]]; then  # iTerm window 0, tab 0, pane 0
        tmux new -s main; exit
    fi
else
    # First tmux pane and not in Vim
    if [[ $(tmux list-panes | wc -l) -eq 1 && -z ${VIM+x} ]]; then
        $DOTFILES_PATH/scripts/welcome.sh
    fi
fi


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
# Oh-my-zsh
#--------------------------------------------------------------------------

plugins=(
    colored-man-pages
    shrink-path
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
# Prompt
#--------------------------------------------------------------------------

# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
sm_set_prompt() {
    SM_PATH_SHORT='$(shrink_path -l -t)'
    if [ -n "$KEYMAP" ] && [ "$KEYMAP" = "vicmd" ]; then
        SM_PROMPT_MODE_START=""
        SM_PROMPT_MODE_STOP="  "
    else
        SM_PROMPT_MODE_START="%S"
        SM_PROMPT_MODE_STOP="%s "
    fi

    # %(?.) - Conditional for previous status
    export PROMPT=$'\n'"%(?.${SM_PROMPT_MODE_START}%F{blue}.${SM_PROMPT_MODE_START}%F{red})${SM_PATH_SHORT}${SM_PROMPT_MODE_STOP}%f"
}
sm_set_prompt  # Set on shell init

# https://linux.die.net/man/1/zshzle
zle-keymap-select() {
    sm_set_prompt
    zle reset-prompt
}
zle -N zle-keymap-select

# Prompt git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info 2> /dev/null }  # Ignore errors, specifically within bare repositories
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{cyan}%b%f'  # %r = repo
zstyle ':vcs_info:*' enable git

autoload -Uz promptinit
promptinit


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

alias ls="exa"
alias ll="exa -l"
alias la="exa -la"
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias diff="nvim -d"
alias t="task"
alias lg="lazygit"
alias cddotfiles="cd $DOTFILES_PATH"
alias cddf="cddotfiles"
alias cdnotes="cd $NOTES_PATH"
alias cddev="cd /Users/sean/Documents/Development/"
alias cdseanmeek="cd /Users/sean/Documents/Development/seanmeek.com/"
alias cdsm="cdseanmeek"
alias cdttn="cd /Users/sean/Documents/Development/TeeTimeNotify/"
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


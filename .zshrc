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

# Profiling, use with `zprof` command
#zmodload zsh/zprof

export ZSH="/Users/sean/.oh-my-zsh"

export CONFIG_PATH="$HOME/Documents/Development/Config/"
export SCHOOL_MS_PATH="$HOME/Documents/School/MS_DU_Cybersecurity/"
export SCHOOL_MS_2022_WINTER_PATH="$SCHOOL_MS_PATH/2021-2022/Winter"

HYPHEN_INSENSITIVE="true"  # Used in completion
# ENABLE_CORRECTION="true"  # Command auto-correction
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  git
  colored-man-pages
  shrink-path
  )

source $ZSH/oh-my-zsh.sh

# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
PROMPT='%F{blue}$(shrink_path -l -t)%f %(?.%F{cyan}:).%F{red}:()%f '

# Prompt git integration
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{yellow}%b%f' # %r is repo
zstyle ':vcs_info:*' enable git

autoload -Uz promptinit
promptinit

bindkey -e  # Use emacs keybindings even if our EDITOR is set to vi

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

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''

# GNU only ('dircolors')
#zstyle ':completion:*' menu select=2 eval "$(dircolors -b)"
# Replacement ('coreutils' required)
zstyle ':completion:*' menu select=2 eval "$(gdircolors -b)"

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###-tns-completion-start-###
if [ -f /Users/sean/.tnsrc ]; then
    source /Users/sean/.tnsrc
fi
###-tns-completion-end-###

$CONFIG_PATH/scripts/welcome.sh  # Startup/welcome script

# Python
alias pip=pip3

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Golang
export GOPATH=$HOME/Documents/Development/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias diff="nvim -d"
alias ls="gls -lah --color --group-directories-first"
alias t="task"
alias go.config="cd $CONFIG_PATH"
alias go.dev="cd /Users/sean/Documents/Development/"
alias go.seanmeek="cd /Users/sean/Documents/Development/seanmeek.com/"
alias go.ttn="cd /Users/sean/Documents/TeeTimeNotify/"
alias go.foren="cd $SCHOOL_MS_2022_WINTER_PATH/ComputerForensics_COMP3731/"
alias go.secur="cd $SCHOOL_MS_2022_WINTER_PATH/ComputerSecurity_COMP4721/"
alias g.sip="git reset --soft HEAD~1; git commit --all --amend --no-edit" # g.sip: "git, squash into parent"
#alias do.awake="caffeinate -dimsu &"  # Prevent sleep ('caffeinate' required)

# Replace all in directory
repl(){
  if [[ $# -eq 3 ]]; then
    read -p "Are you sure you want to replace all occurrences of $2 with $3 in $1? [y/N] " -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rg -l "$2" $1 | xargs -n1 -I{} gsed -i "s/$2/$3/g" {}
      echo 'Replaced all occurrences of $2 with $3 in $1.'
    fi
  else
    echo 'usage: repl <directory> <search-string> <replace-string>\n' >&2
    return 2
  fi
}

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


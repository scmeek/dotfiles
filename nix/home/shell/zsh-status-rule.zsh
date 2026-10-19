# Status-aware separator between commands.
autoload -Uz add-zsh-hook

typeset -g _status_rule_started=0
typeset -g _status_rule_pending=0

_status_rule_preexec() {
  _status_rule_pending=1
}

_status_rule_precmd() {
  local exit_code=$?

  if ((! _status_rule_started)); then
    _status_rule_started=1
    return 0
  fi

  local line="${(l:$COLUMNS::─:)}"

  if ((! _status_rule_pending)); then
    print -P "\n%F{8}${line}%f"
  elif ((exit_code == 0)); then
    print -P "%F{green}${line}%f"
  else
    print -P "%B%F{red}${line}%f%b"
  fi

  _status_rule_pending=0
}

add-zsh-hook preexec _status_rule_preexec
add-zsh-hook precmd _status_rule_precmd

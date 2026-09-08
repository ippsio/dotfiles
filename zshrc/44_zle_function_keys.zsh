#!/usr/bin/env zsh
execute_zle_f2() {
  if [[ -n "$BUFFER" ]]; then
    zle self-insert
    return 0
  fi
  BUFFER="claude"
  zle accept-line
}
execute_zle_f6() {
  if [[ -n "$BUFFER" ]]; then
    zle self-insert
    return 0
  fi

  bgjobs=$(jobs | wc -l| tr -d ' ')
  if [[ $bgjobs -eq 0 ]]; then
    BUFFER="exit"
    zle accept-line
  else
    BUFFER="fg"
    zle accept-line
  fi
}

zle -N execute_zle_f2
bindkey '^[OQ' execute_zle_f2

zle -N execute_zle_f6
bindkey '^[[17~' execute_zle_f6


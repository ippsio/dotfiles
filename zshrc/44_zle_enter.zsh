#!/usr/bin/env zsh
execute_zle_enter() {
  if [[ "${BUFFER}" == ".." ]]; then
    BUFFER="cd .."
    zle accept-line
    return 0
  fi

  if [[ "${BUFFER}" == "dotfiles" ]]; then
    BUFFER="cd ~/dotfiles/"
    zle accept-line
    return 0
  fi

  #if [[ "${BUFFER}" == "pss" ]]; then
  #  BUFFER=" $(ps_fzf)"
  #  zle reset-prompt
  #  zle beginning-of-line
  #  return 0
  #fi

  zle accept-line
  return 0
}

zle -N execute_zle_enter
bindkey '^M' execute_zle_enter

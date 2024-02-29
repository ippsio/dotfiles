#!/usr/bin/env zsh
execute_zle_enter() {
  if [[ "${BUFFER}" == ".." ]]; then
    BUFFER="cd .."
    zle accept-line
    return 0
  fi

  if [[ "${BUFFER}" == ".dotfiles" ]]; then
    BUFFER="cd ~/dotfiles/"
    zle accept-line
    return 0
  fi

  if [[ "${BUFFER}" == ".nvim" ]]; then
    BUFFER="cd ~/dotfiles/.config/nvim/"
    zle accept-line
    return 0
  fi

  zle accept-line
  return 1
}

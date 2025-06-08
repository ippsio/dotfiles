#!/usr/bin/env zsh
zle_ctrl_j() {
  zle down-history
  return 0
}

zle -N zle_ctrl_j
bindkey "^J" zle_ctrl_j



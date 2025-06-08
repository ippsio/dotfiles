#!/usr/bin/env zsh
zle_ctrl_k() {
  zle up-history
  return 0
}

zle -N zle_ctrl_k
bindkey "^K" zle_ctrl_k


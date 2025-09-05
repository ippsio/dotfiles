#!/usr/bin/env zsh
zle_ctrl_j() {
  zle down-history
}
zle -N zle_ctrl_j
bindkey "^J" zle_ctrl_j

zle_ctrl_k() {
  zle up-history
}
zle -N zle_ctrl_k
bindkey "^K" zle_ctrl_k

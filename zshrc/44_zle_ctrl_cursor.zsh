#!/usr/bin/env zsh

# <Left> で親階層のフォルダに移動
execute_zle_left() {
  if [[ -z "$BUFFER" ]]; then
    BUFFER="cd .."
    zle accept-line;
  else
    zle backward-char
  fi
}
zle -N execute_zle_left
bindkey "^[[D" execute_zle_left


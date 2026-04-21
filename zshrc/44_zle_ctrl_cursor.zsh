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

# <Right> で、yaziを実行する関数y、またはforward-charを実行する。
execute_zle_right() {
  if [[ -z "$BUFFER" ]]; then
    BUFFER="y"
    zle accept-line
  else
    zle forward-char
  fi
}
zle -N execute_zle_right
bindkey "^[[C" execute_zle_right
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(execute_zle_right)

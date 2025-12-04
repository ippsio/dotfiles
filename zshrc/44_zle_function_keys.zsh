#!/usr/bin/env zsh
execute_zle_f6() { [[ -z "$BUFFER" ]] && exit 0 || zle self-insert }
zle -N execute_zle_f6
bindkey '^[[17~' execute_zle_f6


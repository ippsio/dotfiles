#!/bin/sh
export FZF_DEFAULT_OPTS="\
  -e \
  --extended \
  --reverse \
  --border \
  --bind change:top \
  --bind 'ctrl-v:execute(vim {})' \
  "
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --color=dark
# --color=fg:-1,bg:-1,hl:#5fff87,fg+:#ffff00,bg+:#666655,hl+:#a3be8c
# --color=info:#af87ff,header:#5fff87,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7'

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
--color fg:-1,bg:-1,hl:226,fg+:226,bg+:239,hl+:226
--color info:108,prompt:48,spinner:108,pointer:168,marker:168'

export FZF_TMUX=1
export FZF_TMUX_HEIGHT=10

N="fzf"
if ! (type "fzf" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install fzf
else
  log_exist $N
fi

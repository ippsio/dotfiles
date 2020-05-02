#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }
# export FZF_DEFAULT_OPTS=$(echo "-e --extended --cycle --reverse --border --color" \
#   "fg:248,hl:202,fg+:214,bg+:92,hl+:231 --color info:44,prompt:67,spinner:209,pointer:103,marker:173")

export FZF_DEFAULT_OPTS="\
  -e \
  --extended \
  --cycle \
  --reverse \
  --border \
  --color \
  fg:248,hl:202,fg+:214,bg+:92,hl+:231 \
  --color \
  info:44,prompt:67,spinner:209,pointer:103,marker:173 \
  --bind 'ctrl-v:execute(vim {})' \
  "

export FZF_TMUX=1
export FZF_TMUX_HEIGHT=10

N="fzf"
if ! (type "fzf" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install fzf
else
  log_exist $N
fi


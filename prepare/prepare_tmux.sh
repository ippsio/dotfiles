#!/bin/sh
N="tmux"
if ! (type "tmux" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install tmux || return 1
fi

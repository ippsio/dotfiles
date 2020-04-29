#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="fzf"
if ! (type "fzf" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install fzf
else
  log_exist $N
fi


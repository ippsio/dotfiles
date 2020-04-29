#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="neovim"
if ! (type "nvim" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install neovim
else
  log_exist $N
fi

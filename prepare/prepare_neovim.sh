#!/bin/sh
# ---------------------------------------------------------------------------------------------------------------------
N="neovim"
if ! (type "nvim" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install neovim
else
  log_exist $N
fi

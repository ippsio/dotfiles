#!/bin/sh
N="tig"
if ! (type "tig" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install tig || return 1
fi

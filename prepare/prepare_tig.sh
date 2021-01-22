#!/bin/sh
N="tig"
if ! (type "tig" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install tig
else
  log_exist $N
fi

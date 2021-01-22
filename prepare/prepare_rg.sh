#!/bin/sh
N="rg"
if ! (type "rg" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install rg
else
  log_exist $N
fi

#!/bin/sh
N="direnv"
if ! (type "direnv" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install direnv
else
  log_exist $N
fi

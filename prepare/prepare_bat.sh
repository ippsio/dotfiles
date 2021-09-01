#!/bin/sh
N="bat"
if ! (type "bat" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install bat || return 1
fi
export BAT_THEME="GitHub"

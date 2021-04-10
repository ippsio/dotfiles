#!/bin/sh
N="bat"
if ! (type "bat" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install bat
else
  log_exist $N
fi
export BAT_THEME="base16-256"

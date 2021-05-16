#!/bin/sh
N="xz"
if ! (type "xz" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install xz
else
  log_exist $N
fi

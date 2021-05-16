#!/bin/sh
N="xv"
if ! (type "xv" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install xv
else
  log_exist $N
fi

#!/bin/sh
N="nodenv"
D=${NODENV_ROOT}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  brew install nodenv node-build || return 1
fi

#!/bin/sh
N="pyenv"
D=${PYENV_ROOT}
U=https://github.com/pyenv/pyenv.git
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone ${U} ${D} || return 1
fi

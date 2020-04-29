#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="pyenv"
D=${PYENV_ROOT}
U=https://github.com/pyenv/pyenv.git
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone ${U} ${D}
else
  log_exist $N $D
fi

#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="nodenv"
D=${NODENV_ROOT}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  brew install nodenv node-build
else
  log_exist $N $D
fi
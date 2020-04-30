#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="tig"
if ! (type "tig" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install tig
else
  log_exist $N
fi

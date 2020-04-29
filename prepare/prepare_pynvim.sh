#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="pynvim"
if [[ $(pip freeze| grep -c pynvim) -eq 0 ]]; then
  log_not_exist $N
  pip install pynvim
else
  log_exist $N
fi

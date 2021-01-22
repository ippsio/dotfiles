#!/bin/sh
N="pynvim"
if [[ $(pip freeze| grep -c pynvim) -eq 0 ]]; then
  log_not_exist $N
  pip3 install pynvim
else
  log_exist $N
fi

#!/bin/sh
N="pynvim"
if [[ $(python3 -m pip freeze| grep -c pynvim) -eq 0 ]]; then
  log_not_exist $N
  python3 -m pip3 install pynvim --user
else
  log_exist $N
fi

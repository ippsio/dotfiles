#!/bin/sh
N="pynvim"
# pip freeze is slower than 'import pynvim'
#if [[ $(python3 -m pip freeze| grep -c pynvim) -eq 0 ]]; then
if ! ($(echo 'import pynvim'| python3 > /dev/null 2>&1)); then
  log_not_exist $N
  python3 -m pip install pynvim --user || exit 1
fi

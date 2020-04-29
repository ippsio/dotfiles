#!/bin/bash
N="fzf"
if ! (type "fzf" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install fzf
else
  log_exist $N
fi


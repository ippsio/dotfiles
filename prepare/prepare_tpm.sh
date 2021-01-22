#!/bin/sh
N="tpm"
D=${TMUX_PLUGINS}/tpm
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone https://github.com/tmux-plugins/tpm ${D}
else
  log_exist $N $D
fi

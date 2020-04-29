#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

ZPLUG_HOME=~/.cache/zplug
N="zplug"
D=${ZPLUG_HOME}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  mkdir -p ${ZPLUG_HOME}
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
  sleep 5
else
  log_exist $N $D
fi

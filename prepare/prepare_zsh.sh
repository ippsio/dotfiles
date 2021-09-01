#!/bin/sh
# version5.8以上を期待
EXPECTING_MAJOR_VER=5
EXPECTING_MINOR_VER=8

N="zsh(ver ${EXPECTING_MAJOR_VER}.${EXPECTING_MINOR_VER}~)"
if ! (type "zsh" > /dev/null 2>&1) ; then
  log_not_exist $N
  brew install zsh || return 1
else
  # zsh --version した時
  # こう得られる事を期待=> zsh 5.8 (x86_64-apple-darwin17.7.0)
  ZSH_VER=$(zsh --version | awk '{ print $2 }')
  MAJOR=$(echo ${ZSH_VER} | cut -d '.' -f 1)
  MINOR=$(echo ${ZSH_VER} | cut -d '.' -f 2)

  if ! ( test ${MAJOR} -ge ${EXPECTING_MAJOR_VER} && test ${MINOR} -ge ${EXPECTING_MINOR_VER} ); then
    log_not_exist $N
    brew install zsh || return 1
  fi
fi

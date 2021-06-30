#!/bin/sh
N="goenv"
D=${GOENV_ROOT}
U=https://github.com/syndbg/goenv.git
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone ${U} ${D}
else
  log_exist $N $D
fi

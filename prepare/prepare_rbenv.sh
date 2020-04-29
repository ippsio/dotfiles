#!/bin/sh
function log_exist() { echo "[o] exist! '$1'" }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

N="rbenv"
D=${RBENV_ROOT}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone https://github.com/sstephenson/rbenv.git ${D}
  git clone https://github.com/sstephenson/ruby-build.git ${D}/plugins/ruby-build
  cd_was=$(pwd)
  cd ${D}
  src/configure && make -C src
  cd ${cd_was}
else
  log_exist $N $D
fi
eval "$(rbenv init -)"

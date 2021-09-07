#!/bin/sh
N="rbenv"
D=${RBENV_ROOT}
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone https://github.com/sstephenson/rbenv.git ${D} || exit 1
  git clone https://github.com/sstephenson/ruby-build.git ${D}/plugins/ruby-build || exit 1
  cd_was=$(pwd)
  cd ${D}
  src/configure && make -C src || exit 1
  cd ${cd_was}
fi
#eval "$(rbenv init -)"

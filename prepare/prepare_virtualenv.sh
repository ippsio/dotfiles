#!/bin/sh
N="virtualenv"
D=${PYENV_ROOT}/plugins/pyenv-virtualenv
U=git://github.com/yyuu/pyenv-virtualenv.git
if [ ! -d ${D} ]; then
  log_not_exist $N $D
  git clone ${U} ${D}
else
  log_exist $N $D
fi

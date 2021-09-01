#!/bin/sh
PYTHON_VER="3.9.5"
N="Python ${PYTHON_VER}"
if [ "$(cat ~/.python-version 2&>1)" != "${PYTHON_VER}" ]; then
  eval "$(pyenv init --path)"
  if [ $(pyenv versions| grep -c "${PYTHON_VER}") -eq 0 ]; then
    log_not_exist $N
    cd ${PYENV_ROOT}/plugins/python-build/../.. && git pull && cd -
    pyenv install ${PYTHON_VER} || return 1
  fi
  cd ${HOME} \
    && pyenv global ${PYTHON_VER} \
    && pyenv local ${PYTHON_VER} \
    && pip3 install --upgrade pip \
    || return 1
fi

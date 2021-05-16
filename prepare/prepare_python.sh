#!/bin/sh
PYTHON_VER="3.9.5"
N="Python ${PYTHON_VER}"
# 'pyenv init -' is no longer needed.
#eval "$(pyenv init -)"
if [ "$(pyenv version| awk '{print $1}')" != "${PYTHON_VER}" ]; then
  if [ $(pyenv versions| grep -c "${PYTHON_VER}") -eq 0 ]; then
    log_not_exist $N
    cd ${PYENV_ROOT}/plugins/python-build/../.. && git pull && cd -
    pyenv install ${PYTHON_VER}
  else
    log_exist $N
  fi
  pyenv global ${PYTHON_VER}
  pip3 install --upgrade pip
fi

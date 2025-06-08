#!/usr/bin/env zsh
prepare_by_brew() {
  if ! ( type "$1" > /dev/null 2>&1 ); then
    echo "$1 not found. install."
    brew install ${2:-$1}
  fi
}
nodir_then_gitclone() {
  if [ -z $1 ]; then
    echo "$2 not found. git clone."
    git clone https://github.com/$2 ${3:-$1}
  fi
}
chk_pynvim_or_install() {
  if ! ( python3 -c 'import pynvim' > /dev/null 2>&1 ); then
    echo "pynvim not found. install."
    python3 -m pip install pynvim --user
  fi
}
chkfile_or_flink() {
  if [ ! -L $1 ]; then
    echo "$1 not found. link! ($1<-$2)"
    ln -s $2 $1
  fi
}
chkfile_or_dlink() {
  if [ ! -d $1 ]; then
    echo "$1 not found. link! ($1<-$2)"
    ln -s $2 $1
  fi
}


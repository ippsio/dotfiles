#!/bin/sh
CDDT=~/.cache/dein_$(date +'%Y%m%d_%H%M%S')
mkdir -p ${CDDT}
rm -rf ~/.cache/dein
ln -sF ${CDDT} ~/.cache/dein
sh -c "curl https://raw.githubusercontent.com/Shougo/dein-installer.vim/master/installer.sh -o ~/.cache/dein/installer.sh"
sh ~/.cache/dein/installer.sh "~/.cache/dein" --use-vim-config
rm ~/.vimrc
rm ~/.vimrc.pre-dein-vim
rm ~/.vimrc-*.pre-dein-vim

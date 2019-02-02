#!/bin/sh

rm -rf ~/.cache/dein
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh -o /tmp/dein_installer.sh
sh /tmp/dein_installer.sh ~/.cache/dein
rm -rf /tmp/dein_installer.sh


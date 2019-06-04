#!/bin/sh
cd $(dirname $0)
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
pip install psutil powerline-shell


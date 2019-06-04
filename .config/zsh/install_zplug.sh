#!/bin/sh
cd ~/.cache
export ZPLUG_HOME=~/.cache/zplug
mkdir -p ${ZPLUG_HOME}
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
pip install psutil powerline-shell


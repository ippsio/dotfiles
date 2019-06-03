#!/bin/sh

export ZPLUG_HOME=~/dotfiles/zsh/.zplug

brew install zsh

echo `which zsh` | sudo tee -a /etc/shells

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh


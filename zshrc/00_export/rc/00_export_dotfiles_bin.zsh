#!/usr/bin/env zsh

if [[ -d ~/dotfiles/bin/ ]]; then
  for dir in $(find ~/dotfiles/bin -type d); do
    PATH="$dir:$PATH"
  done
fi
export PATH

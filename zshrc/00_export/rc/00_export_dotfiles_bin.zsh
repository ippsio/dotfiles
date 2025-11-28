#!/usr/bin/env zsh
dirs=($HOME/dotfiles/bin/**/*(/N))
export PATH="${(j/:/)dirs}:$PATH"

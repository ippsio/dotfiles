#!/usr/bin/env zsh
dirs=($HOME/dotfiles/bin/**/*(/N))
PATH="${(j/:/)dirs}:$PATH"

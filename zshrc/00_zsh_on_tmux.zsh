#!/usr/bin/env zsh
source $HOME/dotfiles/zshrc/00_zsh_on_tmux_funcs.zsh

if tmux_available; then
  tmux_session_new
  while true; do
    tmux_session_attach || exit
  done
fi

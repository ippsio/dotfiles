#!/usr/bin/env zsh
source ~/dotfiles/zshrc/00_zsh_on_tmux_funcs.zsh

if tmux_executable && am_not_i_on_tmux; then
  tmux_session_new
  while true; do
    tmux_session_attach || exit
  done
fi

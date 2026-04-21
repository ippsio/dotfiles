#!/usr/bin/env zsh
source $HOME/dotfiles/zshrc/00_provision_tmux_funcs.zsh
if ! tmux_usable_environment; then
  return
fi

if not_on_tmux_yet; then
  while true; do
    tmux_session_new
    tmux_wait_for_bye && break
  done

  while true; do
    tmux_session_attach || exit
  done
fi

export TMUX_LOGFILE_PATH=$(tmux_logfile_path)
start_tmux_logging "$TMUX_LOGFILE_PATH"

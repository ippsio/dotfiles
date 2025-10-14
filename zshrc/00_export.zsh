#!/usr/bin/env zsh
export EDITOR=nvim
export ZINIT_ROOT="$HOME/.zinit"
export TMUX_PLUGINS="$HOME/.cache/tmux/plugins"

for f in $HOME/dotfiles/zshrc/00_export/rc/*.zsh; do
  source "$f"
done
export PATH

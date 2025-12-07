#!/usr/bin/env zsh
export EDITOR=nvim
export TMUX_PLUGINS="$HOME/.cache/tmux/plugins"

rcs=($HOME/dotfiles/zshrc/00_export/rc/*.zsh(N))
for f in $rcs; do
  source "$f"
done
export PATH

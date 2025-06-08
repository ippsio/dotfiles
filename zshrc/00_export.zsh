#!/usr/bin/env zsh
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZINIT_ROOT=~/.zinit
export TMUX_PLUGINS=~/.cache/tmux/plugins
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/.fzfrc

for f in ~/dotfiles/zshrc/00_export/rc/*.zsh; do source "$f"; done
for d in $(
  find ~/dotfiles/bin -type d
  find -s /opt/homebrew/Cellar/git/*/share/git-core/contrib/diff-highlight -type d -depth 0
  ); do PATH=${PATH}:${d}; done

export PATH


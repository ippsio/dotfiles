#!/usr/bin/env zsh
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZINIT_ROOT=~/.zinit
export TMUX_PLUGINS=~/.cache/tmux/plugins

for f in ~/dotfiles/zshrc/00_export/rc/*.zsh; do source "$f"; done
for d in $(
  find ~/dotfiles/bin -type d
  find -s /opt/homebrew/Cellar/git/*/share/git-core/contrib/diff-highlight -type d -depth 0
  ); do PATH=${PATH}:${d}; done

export PATH

#export FZF_DEFAULT_OPTS='--ansi --exact --reverse --prompt="❯ " --color hl:#ffaf00,bg+:#a7a7a7,hl+:#ffd700'
export FZF_DEFAULT_OPTS='--ansi --exact --reverse --prompt="❯ " --color hl:#ffaf00,bg+:248'

#!/usr/bin/env zsh
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZINIT_ROOT=~/.zinit
export TMUX_PLUGINS=~/.cache/tmux/plugins

for file in ~/dotfiles/zshrc/00_export/rc/*.zsh; do
  source "${file}"
done

diff_highlight_path=$(find -s /opt/homebrew/Cellar/git/*/share/git-core/contrib/diff-highlight -depth 0)
for dir in $(find ~/dotfiles/bin -type d); do
  export PATH=${PATH}:${dir}
done
export PATH=${diff_highlight_path}:${PATH}


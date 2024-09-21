#!/usr/bin/env zsh
my_chpwd() { ~/dotfiles/bin/tmux/tmux_pane_style_with_env; return 0; }
add-zsh-hook chpwd my_chpwd

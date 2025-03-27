#!/usr/bin/env zsh
autoload -Uz add-zsh-hook
my_chpwd() { ~/dotfiles/bin/tmux/tmux_pane_style_with_env; return 0; }
my_precmd_hook() { ~/dotfiles/bin/tmux/tmux_pane_style_with_env; return 0; }
my_preexec_hook() { ~/dotfiles/bin/tmux/tmux_pane_style_with_env; return 0; }

# zshのフック登録
add-zsh-hook chpwd my_chpwd
add-zsh-hook precmd my_precmd_hook
add-zsh-hook preexec my_preexec_hook

# add-zsh-hook zshaddhistory my_zshaddhistory_hook
# add-zsh-hook periodic my_periodic_hook

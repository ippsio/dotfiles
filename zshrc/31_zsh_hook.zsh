#!/usr/bin/env zsh
autoload -Uz add-zsh-hook
my_chpwd() {
  $HOME/dotfiles/bin/tmux/tmux_pane_style_with_env
}
my_precmd_hook() {
  $HOME/dotfiles/bin/tmux/tmux_pane_style_with_env
}
my_preexec_hook() {
  $HOME/dotfiles/bin/tmux/tmux_pane_style_with_env
}

# zshのフック登録
add-zsh-hook chpwd my_chpwd
add-zsh-hook precmd my_precmd_hook
add-zsh-hook preexec my_preexec_hook


#!/usr/bin/env zsh
# NOTE: エスケープシーケンスは cat -vで調べられるよ。

# emacs like
bindkey -e

# del(=ctrl-d)で前方削除
#bindkey "^[[3~" delete-char

source ~/dotfiles/zshrc/41_zle_space.zsh
source ~/dotfiles/zshrc/42_zle_tab.zsh
source ~/dotfiles/zshrc/43_zle_ctrl_f.zsh
source ~/dotfiles/zshrc/43_zle_ctrl_g.zsh
source ~/dotfiles/zshrc/43_zle_ctrl_j.zsh
source ~/dotfiles/zshrc/43_zle_ctrl_k.zsh

# Shift+<Left> で親階層のフォルダに移動
execute_zle_shift_left() { BUFFER="cd .." && zle accept-line; }
zle -N execute_zle_shift_left
bindkey "^[[1;2D" execute_zle_shift_left

source ~/dotfiles/zshrc/44_zle_enter.zsh


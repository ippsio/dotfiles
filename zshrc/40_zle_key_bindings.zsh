#!/usr/bin/env zsh
# emacs like
bindkey -e

# space
source ~/dotfiles/zshrc/41_zle_space.zsh
zle -N zle_space
bindkey " " zle_space

# ctrl-i(=tab)
if false; then
  source ~/dotfiles/zshrc/42_zle_tab.zsh
  zle -N triggered_by_tab
  bindkey "^I" triggered_by_tab
fi

# ctrl-d(=del)で前方削除
bindkey "^[[3~" delete-char

# ctrl-f
source ~/dotfiles/zshrc/43_zle_ctrl_f.zsh
zle -N zle_ctrl_f
bindkey "^F" zle_ctrl_f

# ctrl-space
zle_ctrl_space() {
  A_COMMAND=$(echo "${BUFFER}"| awk '{ print $1 }')
  COMMANDS=(vim nvim ls cp mv)
  printf '%s\n' ${COMMANDS}| grep --line-regexp --silent "${A_COMMAND}" && zle_ctrl_f
  return 0
}

zle -N zle_ctrl_space
bindkey "^ " zle_ctrl_space


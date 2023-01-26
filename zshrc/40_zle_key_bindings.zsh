#!/usr/bin/env zsh
# emacs like
bindkey -e

# space
source ~/dotfiles/zshrc/41_zle_space.zsh
zle -N zle_space
bindkey " " zle_space

# ctrl-i(=tab)
if true; then
  source ~/dotfiles/zshrc/42_zle_tab.zsh
  zle -N triggered_by_tab
  bindkey "^I" triggered_by_tab
fi

# box_bracket_open() { [[ "${LBUFFER: -1}" != "\\" ]] && LBUFFER="${LBUFFER}\\[" || zle self-insert; }
# zle -N box_bracket_open
# bindkey "[" box_bracket_open
# box_bracket_close() { [[ "${LBUFFER: -1}" != "\\" ]] && LBUFFER="${LBUFFER}\\]" || zle self-insert; }
# zle -N box_bracket_close
# bindkey "]" box_bracket_close

# ctrl-d(=del)で前方削除
bindkey "^[[3~" delete-char

# ctrl-f
source ~/dotfiles/zshrc/43_zle_ctrl_f.zsh
zle -N zle_ctrl_f
bindkey "^F" zle_ctrl_f


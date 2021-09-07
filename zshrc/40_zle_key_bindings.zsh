# emacs like
bindkey -e

# スペースキー補完
source ~/dotfiles/zshrc/41_space_triggered.zsh
zle -N triggered_by_space
bindkey " " triggered_by_space

# TAB(=CTRL+I)キー補完
source ~/dotfiles/zshrc/42_tab_triggered.zsh
zle -N triggered_by_tab
bindkey "^I" triggered_by_tab

# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char


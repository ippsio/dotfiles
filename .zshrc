#!/usr/bin/env zsh
tS=$(~/dotfiles/bin/epocms/epocms_c)

autoload -Uz compinit && compinit -u
source ~/dotfiles/zshrc/00_zsh_on_tmux.zsh
source ~/dotfiles/zshrc/00_history.zsh
source ~/dotfiles/zshrc/00_setopt.zsh
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
source ~/dotfiles/zshrc/31_zsh_hook.zsh
source ~/dotfiles/zshrc/40_bindkey.zsh
source ~/dotfiles/zshrc/50_cmd_hack.zsh
source ~/dotfiles/zshrc/60_zsh_plugin.zsh
zsh-defer eval "$(direnv hook zsh)"
zsh-defer eval "$(goenv init -)"
zsh-defer eval "$(nodenv init -)"
zsh-defer eval "$(pyenv init --path)"
zsh-defer eval "$(rbenv init -)"

tE=$(~/dotfiles/bin/epocms/epocms_c)
printf "zshrc loaded (%dms).\n" $((tE - tS))

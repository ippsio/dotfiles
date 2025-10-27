#!/usr/bin/env zsh
t0=$(~/dotfiles/bin/epocms/epocms_c)

autoload -Uz compinit && compinit -u
source ~/dotfiles/zshrc/00_zsh_on_tmux.zsh
source ~/dotfiles/zshrc/00_history.zsh
source ~/dotfiles/zshrc/00_setopt.zsh
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/00_export_color.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
#source ~/dotfiles/zshrc/31_zsh_hook.zsh # 何の意味があったんだっけか、覚えてない...
source ~/dotfiles/zshrc/40_bindkey.zsh
source ~/dotfiles/zshrc/50_cmd_hack.zsh
source ~/dotfiles/zshrc/60_zsh_plugin.zsh
source ~/dotfiles/zshrc/70_init_xxenv.zsh

t1=$(~/dotfiles/bin/epocms/epocms_c)
printf "zshrc loaded (%dms).\n" $((t1 - t0))


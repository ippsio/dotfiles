#!/usr/bin/env zsh
#zmodload zsh/zprof && zprof #zprof 見たい時はコメントアウト外す。
t0=$($HOME/dotfiles/bin/epocms/epocms_c)

autoload -Uz compinit && compinit -u
source $HOME/dotfiles/zshrc/00_zsh_on_tmux.zsh
source $HOME/dotfiles/zshrc/00_history.zsh
source $HOME/dotfiles/zshrc/00_setopt.zsh
source $HOME/dotfiles/zshrc/00_export.zsh
source $HOME/dotfiles/zshrc/00_export_color.zsh
source $HOME/dotfiles/zshrc/10_prepare.zsh
source $HOME/dotfiles/zshrc/20_alias.zsh
source $HOME/dotfiles/zshrc/30_prompt.zsh
source $HOME/dotfiles/zshrc/40_bindkey.zsh
source $HOME/dotfiles/zshrc/50_cmd_hack.zsh
source $HOME/dotfiles/zshrc/60_zsh_plugin.zsh
source $HOME/dotfiles/zshrc/70_eval_envs.zsh

t1=$($HOME/dotfiles/bin/epocms/epocms_c)
td=$(( t1 - t0 ))
printf "zshrc loaded (%dms).\n" $td

#( type "zprof" > /dev/null 2>&1 ) && zprof| less # zprof

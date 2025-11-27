#!/usr/bin/env zsh
# EPOCHREALTIME(UNIX 時間を浮動小数点数で取得できるシェルの組み込み環境変数)を使用できるようにする
zmodload zsh/datetime

#zmodload zsh/zprof && zprof #zprof 見たい時はコメントアウト外す。
t0=$($HOME/dotfiles/bin/epocms/epocms_c)
t0=${${EPOCHREALTIME/./}[1,13]}

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
if [[ -e $HOME/.zshrc_additional ]]; then
  source $HOME/.zshrc_additional
fi

# t1=$($HOME/dotfiles/bin/epocms/epocms_c)
t1=${${EPOCHREALTIME/./}[1,13]}
td=$(( t1 - t0 ))
printf "zshrc loaded (%dms).\n" $td

#( type "zprof" > /dev/null 2>&1 ) && zprof| less # zprof

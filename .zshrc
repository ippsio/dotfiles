#!/usr/bin/env zsh
# zmodload zsh/zprof && zprof

# EPOCHREALTIME(UNIX 時間を浮動小数点数で取得できるシェルの組み込み環境変数)を使用できるようにする
zmodload zsh/datetime
t0=${${EPOCHREALTIME/./}[1,13]}
# with_tat() { local lt0=${${EPOCHREALTIME/./}[1,13]}; "$@"; local lt1=${${EPOCHREALTIME/./}[1,13]}; print -r -- "$* ($(( lt1 - lt0 ))ms)"; return 0; }
autoload -Uz compinit && compinit -u
source $HOME/dotfiles/zshrc/00_provision_tmux.zsh
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

t1=${${EPOCHREALTIME/./}[1,13]}
printf "zshrc loaded (%dms).\n" $(( t1 - t0 ))
type zprof> /dev/null && zprof

#!/usr/bin/env zsh
# zmodload zsh/zprof && zprof

# EPOCHREALTIME(UNIX 時間を浮動小数点数で取得できるシェルの組み込み環境変数)を使用できるようにする
zmodload zsh/datetime
t0=${${EPOCHREALTIME/./}[1,13]}
with_tat() {
  local start=${${EPOCHREALTIME/./}[1,13]}
  "$@"
  local stop=${${EPOCHREALTIME/./}[1,13]}
  local dur_ms=$(( stop - start ))
  print -r -- "$* ($dur_ms ms)"
}
with_tat autoload -Uz compinit && compinit -u
with_tat source $HOME/dotfiles/zshrc/00_zsh_on_tmux.zsh
with_tat source $HOME/dotfiles/zshrc/00_history.zsh
with_tat source $HOME/dotfiles/zshrc/00_setopt.zsh
with_tat source $HOME/dotfiles/zshrc/00_export.zsh
with_tat source $HOME/dotfiles/zshrc/00_export_color.zsh
with_tat source $HOME/dotfiles/zshrc/10_prepare.zsh
with_tat source $HOME/dotfiles/zshrc/20_alias.zsh
with_tat source $HOME/dotfiles/zshrc/30_prompt.zsh
with_tat source $HOME/dotfiles/zshrc/40_bindkey.zsh
with_tat source $HOME/dotfiles/zshrc/50_cmd_hack.zsh
with_tat source $HOME/dotfiles/zshrc/60_zsh_plugin.zsh
with_tat source $HOME/dotfiles/zshrc/70_eval_envs.zsh
if [[ -e $HOME/.zshrc_additional ]]; then
  source $HOME/.zshrc_additional
fi

t1=${${EPOCHREALTIME/./}[1,13]}
printf "zshrc loaded (%dms).\n" $(( t1 - t0 ))
type zprof> /dev/null && zprof

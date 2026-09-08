#!/usr/bin/env zsh
export EDITOR=nvim
export TMUX_PLUGINS="$HOME/.cache/tmux/plugins"

# PATH 重複を自動排除（先頭優先維持）。tmux 継承による PATH 肥大化を防ぐ。
typeset -U path PATH

rcs=($HOME/dotfiles/zshrc/00_export/rc/*.zsh(N))
for f in $rcs; do
  source "$f"
done
export PATH

# tmux セッション内 → 構築済み PATH を tmux グローバル環境へ反映。
# run-shell / #() / status スクリプト(#!/usr/bin/env bash 等)が完全 PATH 参照。
# /opt/homebrew/bin が /bin より前 → `bash` も Homebrew 版(5.x)を拾う。
if [[ -n "$TMUX" ]]; then
  tmux set-environment -g PATH "$PATH"
fi

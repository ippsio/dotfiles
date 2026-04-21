#!/usr/bin/env zsh

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数

zshaddhistory() {
  if [[ $1 == ';'* ]]; then
    # 先頭が ';' で始まる場合は履歴に追加しない
    return 1
  else
    return 0
  fi
}

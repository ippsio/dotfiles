#!/usr/bin/env zsh

# setopts/ unsetopts

# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

# 重複するコマンドは古い方を削除する
setopt hist_ignore_all_dups

# 異なるウィンドウでコマンドヒストリを共有する
setopt share_history

# historyコマンドは履歴に登録しない
setopt hist_no_store

# 余分な空白は詰めて記録
setopt hist_reduce_blanks

# `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt hist_verify

# CTRL-D でログアウトしないようにする
setopt ignore_eof

# Rakeタスク実行時に bundle exec rake hoge:fuga\[some_argument\] のような角括弧のエスケープをしなくても良いものとする。
unsetopt no_nomatch

# ディレクトリの自動スタック機能が利用可能にする。これは dirsコマンドで参照できる。
setopt auto_pushd

# Turn off autocomplete beeps
unsetopt list_beep

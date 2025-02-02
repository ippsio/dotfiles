#!/usr/bin/env zsh

# setopts/ unsetopts
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt ignore_eof # CTRL-D でログアウトしないようにする
unsetopt no_nomatch # Rakeタスク実行時に bundle exec rake hoge:fuga\[some_argument\] のような角括弧のエスケープをしなくても良いものとする。
setopt auto_pushd # ディレクトリの自動スタック機能が利用可能にする。これは dirsコマンドで参照できる。
unsetopt list_beep # Turn off autocomplete beeps

#!/usr/bin/env zsh
# zsh起動時にtmux起動
tmux_attach_to_first_session() {
  unattached_sessions=$(tmux list-session| grep -Ev "\(attached\)")
  if [[ ! -z "${unattached_sessions}" ]]; then
    echo "Unattached tmux sessions found."
    echo "${unattached_sessions}"
    echo "Attached to the first one."
    sleep 1
    session_name=$(echo "${unattached_sessions}"| head -1| awk -F ':' '{ print $1 }')
    tmux attach-session -t "${session_names}"
    echo "bye."
    sleep 1
    return 0
  else
    return 1
  fi
}

tmux_new_session() {
  for i in {1..128}; do
    if [[ -z $(tmux ls -f "#{==:#{session_name},${i}}") ]]; then
      tmux new-session -s ${i}
      echo "bye."
      sleep 1
      break
    fi
  done
  return 0
}

if (type "tmux" > /dev/null 2>&1); then
  if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
    tmux_new_session
    while true; do
      tmux_attach_to_first_session || exit
    done
  fi
fi

autoload -Uz compinit && compinit -u

#zprof 見たい場合はtrue。見たくない場合はfalse。
SHOW_ME_PROFILE=false
${SHOW_ME_PROFILE} && zmodload zsh/zprof && zprof

START=$(~/dotfiles/bin/epocms_c)

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数

# setopts/ unsetopts
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い方を削除する
setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる
setopt ignore_eof # CTRL-D でログアウトしないようにする
setopt NO_NOMATCH # Rakeタスク実行時に bundle exec rake hoge:fuga\[some_argument\] のような角括弧のエスケープをしなくても良いものとする。
setopt AUTO_PUSHD # ディレクトリの自動スタック機能が利用可能にする。これは dirsコマンドで参照できる。
unsetopt LIST_BEEP # Turn off autocomplete beeps

### eval XXenv
eval "$(pyenv init --path)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(goenv init -)"

## source
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
source ~/dotfiles/zshrc/40_zle_key_bindings.zsh
source ~/dotfiles/zshrc/50_existing_command_hacking.zsh

# zsh-plugin manager
source ~/dotfiles/zshrc/60_zsh_plugin_manage.zsh
# theme (fast-theme -l to show theme list.)
#fast-theme  > /dev/null 2>&1

# profiling
( type "zprof" > /dev/null 2>&1 ) && zprof # zprof
printf "zshrc load finished (%dms).\n" $(expr $(~/dotfiles/bin/epocms_c) - $START)


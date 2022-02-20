#!/usr/bin/env zsh
autoload -Uz compinit && compinit
# zmodload zsh/zprof && zprof #zprof 見たい時はコメントアウト外す。

# zsh起動時にtmux起動
(type "tmux" > /dev/null 2>&1) && [[ -z "$TMUX" && ! -z "$PS1" ]] \
  && for i in {0..128}; do [[ -z $(tmux ls -f "#{==:#{session_name},${i}}") ]] && tmux new-session -s ${i} && echo "bye." && sleep 1 && exit; done

epoc_ms() { perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'; }
START=$(epoc_ms)

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
unsetopt LIST_BEEP # Turn off autocomplete beeps

## source
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
source ~/dotfiles/zshrc/40_zle_key_bindings.zsh
source ~/dotfiles/zshrc/50_existing_command_hacking.zsh

### eval XXenv
eval "$(pyenv init --path)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(goenv init -)"

# zsh-plugin manager
source ~/dotfiles/zshrc/60_zsh_plugin_manage.zsh
# theme (fast-theme -l to show theme list.)
fast-theme spa > /dev/null 2>&1

# profiling
( type "zprof" > /dev/null 2>&1 ) && zprof| less # zprof
printf "\n.zshrc load finished (%dms).\n" $(expr $(epoc_ms) - $START)


epoc_ms() { perl -MTime::HiRes -e 'printf("%.0f\n",Time::HiRes::time()*1000)'; }
START=$(epoc_ms)
# zsh起動時にtmux起動
if (type "tmux" > /dev/null 2>&1) ; then
  if [[ -z "$TMUX" && ! -z "$PS1" ]]; then
    for i in {0..128}; do
      [[ -z $(tmux ls -f "#{==:#{session_name},${i}}") ]] \
        && tmux new-session -s ${i} && echo "bye." && sleep 1 && exit
    done
  fi
fi

# source
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
source ~/dotfiles/zshrc/40_zle_key_bindings.zsh
source ~/dotfiles/zshrc/50_existing_command_hacking.zsh

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

### eval **env
eval "$(pyenv init --path)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"
eval "$(nodenv init -)"
eval "$(goenv init -)"

# zplug
source ${ZPLUG_HOME}/init.zsh
zplug "zsh-users/zsh-autosuggestions", hook-load: "ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
zplug 'zsh-users/zsh-completions'
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "Aloxaf/fzf-tab" # 標準のファイル名、ディレクトリ名補完にfzfをつかってくれるようになる
zplug check || zplug install
zplug load #--verbose

TIME=$(expr $(epoc_ms) - $START)
echo "\n.zshrc load finished (${TIME}ms)."

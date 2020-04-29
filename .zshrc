# zsh起動時にtmux起動
if (type "tmux" > /dev/null 2>&1) ; then
  [[ -z "$TMUX" && ! -z "$PS1" ]] && tmux && exit
fi

source ~/dotfiles/prepare.sh

### pyenv/ pyenv-virtualenv
[ -d ${PYENV_ROOT} ] && eval "$(pyenv init -)"

# direnv
direnv version &> /dev/null && eval "$(direnv hook zsh)"

# RUBY
eval "$(rbenv init -)"

# node
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# diff-highlight
DIFF_HL_PATH=/usr/local/share/git-core/contrib/diff-highlight
[ -e ${DIFF_HL}/diff-highlight ] && export PATH=${PATH}:${DIFF_HL_PATH}

# ZPLUG
source ${ZPLUG_HOME}/init.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数
setopt hist_ignore_dups # 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_all_dups # 重複するコマンドは古い法を削除する
setopt share_history # 異なるウィンドウでコマンドヒストリを共有する
setopt hist_no_store # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks # 余分な空白は詰めて記録
setopt hist_verify # `!!`を実行したときにいきなり実行せずコマンドを見せる

# 履歴からコマンド候補をサジェスト
zplug 'zsh-users/zsh-autosuggestions'
zplug "zsh-users/zsh-autosuggestions", hook-load: "ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"

# Zshの補完を拡張してくれる設定が入ったパッケージ
zplug 'zsh-users/zsh-completions'
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
#zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

source ~/dotfiles/zsh/00_alias.zsh
source ~/dotfiles/zsh/10_prompt.zsh
source ~/dotfiles/zsh/20_bindkeys.zsh

REVIEWDOG_DIR=~/inu/
source ~/dotfiles/zsh/custom_functions/git_review.zsh
source ~/dotfiles/zsh/custom_functions/_ssh.zsh

# 未インストール項目をインストールする
zplug check || zplug install

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
# zplug load --verbose
zplug load

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LAST PROCESS
# $HOME/binを先頭にする
export PATH=~/bin:${PATH}

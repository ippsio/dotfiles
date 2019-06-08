# LANGUAGE
# python
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
pyenv --version &> /dev/null
if [ $? -eq 0 ]; then
  eval "$(pyenv init -)"
fi

# ruby
rbenv --version &> /dev/null
if [ $? -eq 0 ]; then
  eval "$(rbenv init -)"
fi

# KEYBINDING
# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char

# ZPLUG
export ZPLUG_HOME=~/.cache/zplug
zplug --version &> /dev/null
if [ ! -d ${ZPLUG_HOME} ]; then
  ~/.config/zsh/install_zplug.sh && sleep 5
fi

source ~/.cache/zplug/init.zsh

source ~/dotfiles/.config/zsh/00_alias.zsh
source ~/dotfiles/.config/zsh/10_prompt.zsh

# 履歴からコマンド候補をサジェスト
zplug 'zsh-users/zsh-autosuggestions'

# Zshの補完を拡張してくれる設定が入ったパッケージ
zplug 'zsh-users/zsh-completions'

zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# cd先のディレクトリのファイル一覧を表示する
# enhancdがない場合
[ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 }
# enhancdがあるときはそのHook機構を使う
[ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1"

: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

# 未インストール項目をインストールする
if ! zplug check --verbose; then
  echo; zplug install
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
#zplug load
zplug load --verbose


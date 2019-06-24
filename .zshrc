# LANGUAGE
## PYTHON
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
pyenv --version &> /dev/null
if [ $? -eq 0 ]; then
  eval "$(pyenv init -)"
fi

# RUBY
rbenv --version &> /dev/null
if [ $? -eq 0 ]; then
  eval "$(rbenv init -)"
fi

# KEYBINDING
# CTRL-D,DELで前方削除
bindkey "^[[3~" delete-char

# tmux
export TMUX_PLUGINS=~/.cache/tmux/plugins
if [ ! -d ${TMUX_PLUGINS} ]; then
  git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGINS}/tpm
fi

# ZPLUG
export ZPLUG_HOME=~/.cache/zplug
zplug --version &> /dev/null
if [ ! -d ${ZPLUG_HOME} ]; then
  ~/.config/zsh/install_zplug.sh && sleep 5
fi

export FZF_DEFAULT_OPTS="--extended --cycle --reverse"
fzf --version &> /dev/null
if [ ! $? -eq 0 ]; then
  brew install fzf
fi

source ~/.cache/zplug/init.zsh

source ~/dotfiles/.config/zsh/00_alias.zsh
source ~/dotfiles/.config/zsh/10_prompt.zsh

# historyj
HISTFILE=~/.zsh_history # ヒストリファイル名
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

# Zshの補完を拡張してくれる設定が入ったパッケージ
zplug 'zsh-users/zsh-completions'

zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
#zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# cd先のディレクトリのファイル一覧を表示する
tree --version &> /dev/null
if [ ! $? -eq 0 ]; then
  brew install tree
fi
# enhancdがない場合
[ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 }
# enhancdがあるときはそのHook機構を使う
[ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1"

# sshコマンド補完を~/.ssh/configから行う
function _ssh { compadd $(fgrep 'Host ' ~/.ssh/config | grep -v '*' |  awk '{print $2}' | sort | fzf) }

# 未インストール項目をインストールする
if ! zplug check --verbose; then
  echo; zplug install
fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
#zplug load
zplug load --verbose

# expand global aliases by space
# http://blog.patshead.com/2012/11/automatically-expaning-zsh-global-aliases---simplified.html
globalias() {
  if [[ $LBUFFER =~ ' [A-Z0-9]+$' ]]; then
    zle _expand_alias
    # zle expand-word
  fi
  zle self-insert
}

zle -N globalias

bindkey " " globalias

# function battery {
#   ~/dotfiles/bin/battery
# }
# 
# function wifi {
#   ~/dotfiles/bin/wifi
# }
# 
# agの結果をfzfで絞り込み選択するとvimで開く
alias agg="_agAndVim"
function _agAndVim() {
    if [ -z "$1" ]; then
        echo 'Usage: agg PATTERN'
        return 0
    fi
    result=`ag $1 | fzf`
    line=`echo "$result" | awk -F ':' '{print $2}'`
    file=`echo "$result" | awk -F ':' '{print $1}'`
    if [ -n "$file" ]; then
        nvim $file +$line
    fi
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

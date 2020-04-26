# zsh起動時にtmux起動
[[ -z "$TMUX" && ! -z "$PS1" ]] && tmux && exit

# ~/dotfiles/bin/内部を /usr/local/bin/にコピー
zsh ~/dotfiles/zsh/oneway_sync.zsh ~/dotfiles/bin/ /usr/local/bin/

# OS
function package_install() {
  echo "-----------------------------------------------------------------"
  echo "INSTALL [$1]"
  if [ "$(uname)" = "Darwin" ]; then
    brew install $1
  elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
    sudo apt install -y $1
  elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
    OS='Cygwin'
  else
    echo "platform ($(uname -a)) is not supported."
  fi
}

export PATH=${PATH}:~/dotfiles/bin
export PATH=${PATH}:~/opt/bin

# LANGUAGE
## PYTHON
### pyenv/ pyenv-virtualenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=${PATH}:$PYENV_ROOT/bin
[ -d ${PYENV_ROOT} ] || git clone https://github.com/pyenv/pyenv.git ${PYENV_ROOT}
[ -d ${PYENV_ROOT}/plugins/pyenv-virtualenv ] || git clone git://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv
[ -d ${PYENV_ROOT} ] && eval "$(pyenv init -)"

PYTHON_VER="3.7.3"
if [ "$(pyenv version| awk '{print $1}')" != "${PYTHON_VER}" ]; then
  if [ $(pyenv versions| grep -c "${PYTHON_VER}") -eq 0 ]; then
    cd ${PYENV_ROOT}/plugins/python-build/../.. && git pull && cd -
    # may be required for ubuntu
    # gcc make zlib1g zlib1g-dev libssl-dev libffi-dev libbz2-dev libreadline-dev libsqlite3-dev
    pyenv install ${PYTHON_VER}
  fi
  pyenv global ${PYTHON_VER}
  pip install --upgrade pip
fi

# pynvim(neovim python provider)
[[ $(pip freeze| grep -c pynvim) -eq 0 ]] && pip install pynvim

# direnv
direnv version &> /dev/null || package_install direnv
direnv version &> /dev/null && eval "$(direnv hook zsh)"

# RUBY
export RBENV_ROOT=$HOME/.rbenv
export PATH=${PATH}:$RBENV_ROOT/bin
if [ ! -d ${RBENV_ROOT} ]; then
  git clone https://github.com/sstephenson/rbenv.git ${RBENV_ROOT}
  git clone https://github.com/sstephenson/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build
  cd_was=$(pwd)
  cd ${RBENV_ROOT}
  src/configure && make -C src
  cd ${cd_was}
fi
eval "$(rbenv init -)"

# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# tmux
export TMUX_PLUGINS=~/.cache/tmux/plugins
[ ! -d ${TMUX_PLUGINS}/tpm ] && git clone https://github.com/tmux-plugins/tpm ${TMUX_PLUGINS}/tpm

# ripgrep(rg)
rg --version &> /dev/null || package_install rg

# diff-highlight
DIFF_HL_PATH=/usr/local/share/git-core/contrib/diff-highlight
[ -e ${DIFF_HL}/diff-highlight ] && export PATH=${PATH}:${DIFF_HL_PATH}

# neovim
export EDITOR=nvim
nvim -version &> /dev/null || (package_install neovim && export EDITOR=nvim)

# ZPLUG
export ZPLUG_HOME=~/.cache/zplug
[ ! -d ${ZPLUG_HOME} ] && ~/dotfiles/zsh/install_zplug.sh && sleep 5
source ${ZPLUG_HOME}/init.zsh

export FZF_DEFAULT_OPTS="--extended --cycle --reverse --color fg:248,hl:202,fg+:214,bg+:92,hl+:231 --color info:44,prompt:67,spinner:209,pointer:103,marker:173"
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=10
fzf --version &> /dev/null || package_install fzf
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
# zplug check --verbose || zplug install
zplug check || zplug install

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
# zplug load --verbose
zplug load

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# LAST PROCESS
# $HOME/binを先頭にする
export PATH=~/bin:${PATH}
#export VIMRUNTIME=~/bin/nvim-linux64/share/nvim/runtime

#!/bin/sh
# python
PYTHON_VER="3.7.3"
export PYENV_ROOT=$HOME/.pyenv
export PATH=${PATH}:$PYENV_ROOT/bin

# ruby
export RBENV_ROOT=$HOME/.rbenv
export PATH=${PATH}:$RBENV_ROOT/bin

# node
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# tmux
export TMUX_PLUGINS=~/.cache/tmux/plugins

# basis
export EDITOR=nvim
export ZPLUG_HOME=~/.cache/zplug
export FZF_DEFAULT_OPTS="--extended --cycle --reverse --color fg:248,hl:202,fg+:214,bg+:92,hl+:231 --color info:44,prompt:67,spinner:209,pointer:103,marker:173"
export FZF_TMUX=1
export FZF_TMUX_HEIGHT=10

# ~/dotfiles/bin/内部を /usr/local/bin/にコピー
bash ~/dotfiles/zsh/oneway_sync.zsh ~/dotfiles/bin/ /usr/local/bin/

function generate_symlink() { [ ! -e $1 ] && ln -s $2 && echo "Symlink generated ($1<-$2)" }

echo "[PREPARING -source] start"
source ~/dotfiles/prepare/prepare_zsh.sh
source ~/dotfiles/prepare/prepare_tmux.sh
source ~/dotfiles/prepare/prepare_neovim.sh
source ~/dotfiles/prepare/prepare_pyenv.sh
source ~/dotfiles/prepare/prepare_virtualenv.sh
source ~/dotfiles/prepare/prepare_python.sh
source ~/dotfiles/prepare/prepare_direnv.sh
source ~/dotfiles/prepare/prepare_pynvim.sh
source ~/dotfiles/prepare/prepare_rbenv.sh
source ~/dotfiles/prepare/prepare_tpm.sh
source ~/dotfiles/prepare/prepare_nvm.sh
source ~/dotfiles/prepare/prepare_rg.sh
source ~/dotfiles/prepare/prepare_diff-highlight.sh
source ~/dotfiles/prepare/prepare_fzf.sh
source ~/dotfiles/prepare/prepare_zplug.sh

echo "[PREPARING generate_symlink] start"
generate_symlink ~/.zshrc ~/dotfiles/.zshrc
generate_symlink ~/.tigrc ~/dotfiles/.tigrc
generate_symlink ~/.tmux.conf ~/dotfiles/.tmux.conf
generate_symlink ~/.gitconfig ~/dotfiles/.gitconfig
generate_symlink ~/.config/nvim ~/dotfiles/.config/nvim

# その他、karabiner等の設定
[ ! -d ~/setting_box ] && git clone https://github.com/ippsio/setting_box.git ~/
generate_symlink ~/.config/karabiner ~/setting_box/.config/karabiner

echo "[PREPARING] finish"

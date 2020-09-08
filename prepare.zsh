#!/usr/bin/env zsh
START_TIME=`date +%s`
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZPLUG_HOME=~/.cache/zplug
export TMUX_PLUGINS=~/.cache/tmux/plugins
export PYENV_ROOT=$HOME/.pyenv
export RBENV_ROOT=$HOME/.rbenv
export NODENV_ROOT=$HOME/.nodenv
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PATH=${PATH}:$PYENV_ROOT/bin:$RBENV_ROOT/bin

# --------------------------------------------
# Copy ~/dotfiles/bin/* into /usr/local/bin/*
#  (For example, tmux status bar uses it)
# --------------------------------------------
sh ~/dotfiles/zsh/oneway_sync ~/dotfiles/prepare/usr/local/bin/ /usr/local/bin/

# ----------------------------------
# Install software if not installed.
# ----------------------------------
echo "[PREPARING] start"
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
source ~/dotfiles/prepare/prepare_tig.sh
source ~/dotfiles/prepare/prepare_diff-highlight.sh
source ~/dotfiles/prepare/prepare_fzf.sh
source ~/dotfiles/prepare/prepare_zplug.sh
source ~/dotfiles/prepare/prepare_bat.sh
source ~/dotfiles/prepare/prepare_nodenv.sh

# -----------------------------------------------------
# Generate link fot real file, directory in this repo.
# -----------------------------------------------------
function generate_symlink_f() { [ ! -f $1 ] && ln -s $2 && echo "Symlink generated ($1<-$2)" }
function generate_symlink_d() { [ ! -d $1 ] && ln -s $2 && echo "Symlink generated ($1<-$2)" }
echo "[PREPARING(generate_symlink)] start"

generate_symlink_d ~/.config/nvim ~/dotfiles/.config/nvim

generate_symlink_f ~/.gitattributes_global ~/dotfiles/.gitattributes_global
generate_symlink_f ~/.gitconfig ~/dotfiles/.gitconfig
generate_symlink_f ~/.gitignore_global ~/dotfiles/.gitignore_global
generate_symlink_f ~/.pryrc ~/dotfiles/.pryrc
generate_symlink_f ~/.tigrc ~/dotfiles/.tigrc
generate_symlink_f ~/.tmux.conf ~/dotfiles/.tmux.conf
generate_symlink_f ~/.zshrc ~/dotfiles/.zshrc

# その他、karabiner等の設定
[ ! -d ~/setting_box ] && git clone https://github.com/ippsio/setting_box.git ~/setting_box
[ ! -d ~/.config/karabiner ] && ln -s ~/setting_box/karabiner ~/.config/karabiner

TURN_AROUND_TIME=$(($(date +%s) - START_TIME))
echo "[PREPARING] finish in ${TURN_AROUND_TIME} sec"


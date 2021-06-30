#!/usr/bin/env zsh
START_TIME=`date +%s`
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZPLUG_HOME=~/.cache/zplug
export TMUX_PLUGINS=~/.cache/tmux/plugins
export PYENV_ROOT=$HOME/.pyenv
export GOENV_ROOT=$HOME/.goenv
export RBENV_ROOT=$HOME/.rbenv
export NODENV_ROOT=$HOME/.nodenv
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export PATH=~/dotfiles/zsh/bin:$PYENV_ROOT/bin:$GOENV_ROOT/bin:$RBENV_ROOT/bin:${PATH}

# LSCOLORS
# a black      , b red      , c green      , d brown      , e blue      , f magenta      , g cyan      , h light grey
# A black(BOLD), B red(BOLD), C green(BOLD), D brown(BOLD), E blue(BOLD), F magenta(BOLD), G cyan(BOLD), H light grey(BOLD)
# x default foreground or background
#
#   (A bold black, usually shows up as dark grey)
#   (D bold brown, usually shows up as yellow)
#   (H bold light grey; looks like bright white)
#
_C1=gx # 1. directory
_C2=fx # 2. symbolic link
_C3=cx # 3. socket
_C4=dx # 4. pipe
_C5=bx # 5. executable
_C6=dg # 6. block special
_C7=dx # 7. character special
_C8=ab # 8. executable with setuid bit set
_C9=ag # 9. executable with setgid bit set
_C10=ac # 10. directory writable to others, with sticky bit
_C11=ad # 11. directory writable to others, without sticky bit
export LSCOLORS=${_C1}${_C2}${_C3}${_C4}${_C5}${_C6}${_C7}${_C8}${_C9}${_C10}${_C11}

export LANG="ja_JP.UTF-8"
export LC_COLLATE="ja_JP.UTF-8"
export LC_CTYPE="ja_JP.UTF-8"
export LC_MESSAGES="ja_JP.UTF-8"
export LC_MONETARY="ja_JP.UTF-8"
export LC_NUMERIC="ja_JP.UTF-8"
export LC_TIME="ja_JP.UTF-8"
export LC_ALL=

# --------------------------------------------
# Copy ~/dotfiles/bin/* into /usr/local/bin/*
#  (For example, tmux status bar uses it)
# --------------------------------------------
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
[ ! -d /usr/local/bin ] && sudo mkdir /usr/local/bin
sh ~/dotfiles/zsh/oneway_sync ~/dotfiles/prepare/usr/local/bin/ /usr/local/bin/ "sudo"

# ----------------------------------
# Install software if not installed.
# ----------------------------------

function log_exist() { echo -n "$1[ok], " }
function log_not_exist() { echo "------------\n[x] not found! '$1' " }

printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -
echo -n "[PREPARING] "
source ~/dotfiles/prepare/prepare_xz.sh
source ~/dotfiles/prepare/prepare_neovim.sh
source ~/dotfiles/prepare/prepare_pynvim.sh
source ~/dotfiles/prepare/prepare_zsh.sh
source ~/dotfiles/prepare/prepare_tmux.sh
source ~/dotfiles/prepare/prepare_pyenv.sh
source ~/dotfiles/prepare/prepare_goenv.sh
source ~/dotfiles/prepare/prepare_virtualenv.sh
source ~/dotfiles/prepare/prepare_python.sh
source ~/dotfiles/prepare/prepare_direnv.sh
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
echo

# -----------------------------------------------------
# Generate link fot real file, directory in this repo.
# -----------------------------------------------------
function generate_symlink_f() { [ ! -f $1 ] && ln -s $2 $1 && echo "Symlink generated ($1<-$2)" }
function generate_symlink_d() { [ ! -d $1 ] && ln -s $2 $1 && echo "Symlink generated ($1<-$2)" }
echo -n "(generate_symlink) "

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
printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -


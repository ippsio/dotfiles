#!/usr/local/env zsh
type_or_inst() {
  ( type "$1" > /dev/null 2>&1 ) && echo -n "($1 ok) " && return 0
  brew install ${2:-$1} && echo "$1 not found so tried to install."; return 1
}
nodir_then_gitclone() {
  [ -d $1 ] && echo -n "($2 ok) " && return 0
  git clone https://github.com/$2 ${3:-$1}; echo "$2 not found so tried to git clone."; return 1
}
chk_pynvim_or_install() {
  $(echo 'import pynvim'| python3 > /dev/null 2>&1) && echo -n "(pynvim ok) " && return 0
  python3 -m pip install pynvim --user; echo "pynvim not found so tried to install."; return 1
}
chkfile_or_flink() {
  [ -L $1 ] && echo -n "(${1//${HOME}/~} ok) " && return 0
  ln -s $2 $1; echo "$1 not found so tried to link! ($1<-$2)"; return 1
}
chkfile_or_dlink() {
  [ -d $1 ] && echo -n "(${1//${HOME}/~} ok) " && return 0
  ln -s $2 $1; echo "$1 not found so tried to link! ($1<-$2)"; return 1
}

type_or_inst xz
type_or_inst nvim neovim
type_or_inst zsh
type_or_inst tmux
type_or_inst direnv
type_or_inst rg
type_or_inst tig
type_or_inst fzf
type_or_inst bat
type_or_inst pyenv
type_or_inst pyenv-virtualenv
type_or_inst goenv
type_or_inst rbenv
type_or_inst ruby-build

type_or_inst nodenv
nodir_then_gitclone "${TMUX_PLUGINS}/tpm" "tmux-plugins/tpm"
nodir_then_gitclone "${ZINIT_ROOT}" "zdharma/zinit.git" "${ZINIT_ROOT}/bin"
nodir_then_gitclone "${HOME}/setting_box" "ippsio/setting_box.git"

chk_pynvim_or_install

# check link.
chkfile_or_dlink ~/.config/nvim          ~/dotfiles/.config/nvim
chkfile_or_dlink ~/.config/bat           ~/dotfiles/.config/bat
chkfile_or_dlink ~/.config/karabiner     ~/setting_box/karabiner

chkfile_or_flink ~/.gitattributes_global ~/dotfiles/.gitattributes_global
chkfile_or_flink ~/.gitconfig            ~/dotfiles/.gitconfig
chkfile_or_flink ~/.gitignore_global     ~/dotfiles/.gitignore_global
chkfile_or_flink ~/.pryrc                ~/dotfiles/.pryrc
chkfile_or_flink ~/.tigrc                ~/dotfiles/.tigrc
chkfile_or_flink ~/.tmux.conf            ~/dotfiles/.tmux.conf
chkfile_or_flink ~/.zshrc                ~/dotfiles/.zshrc


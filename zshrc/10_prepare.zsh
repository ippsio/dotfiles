#!/usr/bin/env zsh
readonly VERBOSE=1

type_or_inst() {
  if ( type "$1" > /dev/null 2>&1 ); then
    echo -n "$1 ok, "
    return 0
  else
    echo "$1 not found. install."
    brew install ${2:-$1}
    return 1
  fi
}
type_or_cask_inst() {
  if ( brew list --cask| grep -E "^${1}$" > /dev/null 2>&1 ); then
    echo -n "$1 ok, "
    return 0
  else
    echo "$1 not found. install."
    brew install --cask ${2:-$1}
    return 1
  fi
}
type_or_cargo_inst() {
  if ( type "$1" > /dev/null 2>&1 ); then
    echo -n "$1 ok, "
    return 0
  else
    echo "$1 not found. install."
    cargo install ${2:-$1}
    return 1
  fi
}
nodir_then_gitclone() {
  if [ -d $1 ]; then
    echo -n "$2 ok, "
    return 0
  else
    echo "$2 not found. git clone."
    git clone https://github.com/$2 ${3:-$1}
    return 1
  fi
}
chk_pynvim_or_install() {
  if ( python3 -c 'import pynvim' > /dev/null 2>&1 ); then
    echo -n "pynvim ok, "
    return 0
  else
    echo "pynvim not found. install."
    python3 -m pip install pynvim --user
    return 1
  fi
}
chkfile_or_flink() {
  if [ -L $1 ]; then
    echo -n "${1//${HOME}/~} ok, "
    return 0
  else
    echo "$1 not found. link! ($1<-$2)"
    ln -s $2 $1
    return 1
  fi
}
chkfile_or_dlink() {
  if [ -d $1 ]; then
    echo -n "${1//${HOME}/~} ok, "
    return 0
  else
    echo "$1 not found. link! ($1<-$2)"
    ln -s $2 $1
    return 1
  fi
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
type_or_inst deno
type_or_inst rustc rust
type_or_inst cargo
type_or_cargo_inst mocword
type_or_cask_inst stats
nodir_then_gitclone "${TMUX_PLUGINS}/tpm" "tmux-plugins/tpm"
nodir_then_gitclone "${ZINIT_ROOT}" "zdharma/zinit.git" "${ZINIT_ROOT}/bin"
nodir_then_gitclone "${HOME}/setting_box" "ippsio/setting_box.git"
# Universal ctags. It is for vim-scripts/taglist.vim
# type_or_inst universal-ctags
( ctags --version|grep "Universal Ctags" 2>&1 > /dev/null ) || brew install universal-ctags
chk_pynvim_or_install

# check link.
chkfile_or_dlink ~/.config/nvim          ~/dotfiles/.config/nvim
chkfile_or_dlink ~/.config/bat           ~/dotfiles/.config/bat
chkfile_or_dlink ~/.config/alacritty     ~/dotfiles/.config/alacritty
chkfile_or_dlink ~/.config/karabiner     ~/setting_box/karabiner

chkfile_or_flink ~/.gitattributes_global ~/dotfiles/.gitattributes_global
chkfile_or_flink ~/.gitconfig            ~/dotfiles/.gitconfig
chkfile_or_flink ~/.gitignore_global     ~/dotfiles/.gitignore_global
chkfile_or_flink ~/.pryrc                ~/dotfiles/.pryrc
chkfile_or_flink ~/.tigrc                ~/dotfiles/.tigrc
chkfile_or_flink ~/.tmux.conf            ~/dotfiles/.tmux.conf
chkfile_or_flink ~/.zshrc                ~/dotfiles/.zshrc


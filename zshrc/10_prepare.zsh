#!/usr/bin/env zsh
may_brew_install() {
  (( $+commands[$1] )) || (set -x; brew install "${2:-$1}")
}
nodir_then_gitclone() {
  [ -d $1 ] || (set -x; git clone https://github.com/$2 ${3:-$1})
}
may_ln_file() {
  [ -L $1 ] || (set -x; ln -s $2 $1)
}
may_ln_dir() {
  [ -d $1 ] || (set -x; ln -s $2 $1)
}

may_brew_install nvim neovim
may_brew_install xz
may_brew_install zsh
may_brew_install direnv
may_brew_install rg
may_brew_install tig
may_brew_install fzf
may_brew_install bat
may_brew_install pyenv
may_brew_install rbenv
may_brew_install ruby-build
may_brew_install rustc rust
may_brew_install cargo
may_brew_install java openjdk
may_brew_install mvn maven
may_brew_install urlview
may_brew_install extract_url
may_brew_install gsed
may_brew_install tmux

nodir_then_gitclone "${TMUX_PLUGINS}/tpm" "tmux-plugins/tpm"

[ -d $HOME/.tmux/log/ ] || mkdir -p $HOME/.tmux/log/
[ -d $HOME/.local/share/tig ] || mkdir -p $HOME/.local/share/tig
[ -d $HOME/.config/karabiner/assets ] || mkdir -p $HOME/.config/karabiner/assets

[ -f $HOME/.local/share/tig/history ] || touch $HOME/.local/share/tig/history

may_ln_dir $HOME/.config/nvim $HOME/dotfiles/.config/nvim
may_ln_dir $HOME/.config/bat $HOME/dotfiles/.config/bat
may_ln_dir $HOME/.config/alacritty $HOME/dotfiles/.config/alacritty
may_ln_dir $HOME/.config/tig $HOME/dotfiles/.config/tig
may_ln_dir $HOME/.config/direnv $HOME/dotfiles/.config/direnv
may_ln_dir $HOME/.config/kitty $HOME/dotfiles/.config/kitty
may_ln_dir $HOME/.config/karabiner/assets/complex_modifications $HOME/dotfiles/.config/karabiner/assets/complex_modifications

may_ln_file $HOME/.gitattributes_global $HOME/dotfiles/.gitattributes_global
may_ln_file $HOME/.gitconfig $HOME/dotfiles/.gitconfig
may_ln_file $HOME/.gitignore_global $HOME/dotfiles/.gitignore_global
may_ln_file $HOME/.pryrc $HOME/dotfiles/.pryrc
may_ln_file $HOME/.tigrc $HOME/dotfiles/.tigrc
may_ln_file $HOME/.tmux.conf $HOME/dotfiles/.tmux.conf
may_ln_file $HOME/.zshrc $HOME/dotfiles/.zshrc

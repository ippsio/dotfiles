#!/usr/bin/env zsh
may_brew_install() {
  (( $+commands[$1] )) || (set -x; brew install "${2:-$1}")
}
nodir_then_gitclone() {
  [ -d $1 ] || (set -x; git clone https://github.com/$2 ${3:-$1})
}
may_ln_file() {
  [ -L "${1/dotfiles\//}" ] || (set -x; ln -s "$1" "${1/dotfiles\//}")
}
may_ln_dir() {
  [ -d "${1/dotfiles\//}" ] || (set -x; ln -s "$1" "${1/dotfiles\//}")
}
ensure_dir() {
  [ -d $1 ] || mkdir -p $1
}
ensure_file() {
  [ -f $1 ] || touch $1
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

ensure_dir $HOME/.tmux/log
ensure_dir $HOME/.local/share/tig
ensure_dir $HOME/.config/karabiner/assets
ensure_file $HOME/.local/share/tig/history

may_ln_dir $HOME/dotfiles/.config/alacritty
may_ln_dir $HOME/dotfiles/.config/bat
may_ln_dir $HOME/dotfiles/.config/direnv
may_ln_dir $HOME/dotfiles/.config/karabiner/assets/complex_modifications
may_ln_dir $HOME/dotfiles/.config/nvim
may_ln_dir $HOME/dotfiles/.config/tig
may_ln_dir $HOME/dotfiles/.config/ripgrep

may_ln_file $HOME/dotfiles/.gitconfig
may_ln_file $HOME/dotfiles/.gitignore_global
may_ln_file $HOME/dotfiles/.pryrc
may_ln_file $HOME/dotfiles/.tigrc
may_ln_file $HOME/dotfiles/.tmux.conf
may_ln_file $HOME/dotfiles/.zshrc

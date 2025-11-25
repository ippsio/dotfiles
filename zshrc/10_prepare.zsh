#!/usr/bin/env zsh
source $HOME/dotfiles/zshrc/10_prepare_funcs.zsh

may_brew_install xz
may_brew_install nvim neovim
may_brew_install zsh
may_brew_install tmux
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

nodir_then_gitclone "${TMUX_PLUGINS}/tpm" "tmux-plugins/tpm"
# chk_pynvim_or_install

# mkdir
mkdir -p ~/.tmux/log/

# check link.
may_ln_dir ~/.config/nvim          ~/dotfiles/.config/nvim
may_ln_dir ~/.config/bat           ~/dotfiles/.config/bat
may_ln_dir ~/.config/alacritty     ~/dotfiles/.config/alacritty
may_ln_dir ~/.config/tig          ~/dotfiles/.config/tig
may_ln_dir ~/.config/direnv          ~/dotfiles/.config/direnv
may_ln_dir ~/.config/kitty          ~/dotfiles/.config/kitty
mkdir -p ~/.local/share/tig
touch ~/.local/share/tig/history

mkdir -p ~/.config/karabiner/assets
may_ln_dir ~/.config/karabiner/assets/complex_modifications     ~/dotfiles/.config/karabiner /assets/ complex_modifications

may_ln_file ~/.gitattributes_global ~/dotfiles/.gitattributes_global
may_ln_file ~/.gitconfig            ~/dotfiles/.gitconfig
may_ln_file ~/.gitignore_global     ~/dotfiles/.gitignore_global
may_ln_file ~/.pryrc                ~/dotfiles/.pryrc
may_ln_file ~/.tigrc                ~/dotfiles/.tigrc
may_ln_file ~/.tmux.conf            ~/dotfiles/.tmux.conf
may_ln_file ~/.zshrc                ~/dotfiles/.zshrc


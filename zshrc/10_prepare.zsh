#!/usr/bin/env zsh
source ~/dotfiles/zshrc/10_prepare_funcs.zsh

prepare_by_brew xz
prepare_by_brew nvim neovim
prepare_by_brew zsh
prepare_by_brew tmux
prepare_by_brew direnv
prepare_by_brew rg
prepare_by_brew tig
prepare_by_brew fzf
prepare_by_brew bat
prepare_by_brew pyenv
prepare_by_brew pyenv-virtualenv
prepare_by_brew goenv
prepare_by_brew rbenv
prepare_by_brew ruby-build
prepare_by_brew nodenv
prepare_by_brew rustc rust
prepare_by_brew cargo
prepare_by_brew java openjdk
prepare_by_brew mvn maven
prepare_by_brew urlview
prepare_by_brew extract_url

nodir_then_gitclone "${TMUX_PLUGINS}/tpm" "tmux-plugins/tpm"
nodir_then_gitclone "${ZINIT_ROOT}" "zdharma/zinit.git" "${ZINIT_ROOT}/bin"
nodir_then_gitclone "${HOME}/setting_box" "ippsio/setting_box.git"
# chk_pynvim_or_install

# mkdir
mkdir -p ~/.tmux/log/

# check link.
chkfile_or_dlink ~/.config/nvim          ~/dotfiles/.config/nvim
chkfile_or_dlink ~/.config/bat           ~/dotfiles/.config/bat
chkfile_or_dlink ~/.config/alacritty     ~/dotfiles/.config/alacritty
chkfile_or_dlink ~/.config/ranger        ~/dotfiles/.config/ranger
chkfile_or_dlink ~/.config/tig          ~/dotfiles/.config/tig
chkfile_or_dlink ~/.config/direnv          ~/dotfiles/.config/direnv
chkfile_or_dlink ~/.config/kitty          ~/dotfiles/.config/kitty
mkdir -p ~/.local/share/tig
touch ~/.local/share/tig/history

mkdir -p ~/.config/karabiner/assets
chkfile_or_dlink ~/.config/karabiner/assets/complex_modifications     ~/dotfiles/.config/karabiner /assets/ complex_modifications

chkfile_or_flink ~/.gitattributes_global ~/dotfiles/.gitattributes_global
chkfile_or_flink ~/.gitconfig            ~/dotfiles/.gitconfig
chkfile_or_flink ~/.gitignore_global     ~/dotfiles/.gitignore_global
chkfile_or_flink ~/.pryrc                ~/dotfiles/.pryrc
chkfile_or_flink ~/.tigrc                ~/dotfiles/.tigrc
chkfile_or_flink ~/.tmux.conf            ~/dotfiles/.tmux.conf
chkfile_or_flink ~/.zshrc                ~/dotfiles/.zshrc


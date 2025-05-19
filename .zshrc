#!/usr/bin/env zsh
source ~/dotfiles/zshrc/00_put_zsh_on_tmux.zsh

autoload -Uz compinit && compinit -u
START_TIME=$(~/dotfiles/bin/epocms/epocms_c)

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000 # メモリに保存される履歴の件数
SAVEHIST=10000 # 履歴ファイルに保存される履歴の件数

### eval XXenv
eval "$(direnv hook zsh)"
eval "$(goenv init -)"
eval "$(nodenv init -)"
eval "$(pyenv init --path)"
eval "$(rbenv init -)"

source ~/dotfiles/zshrc/00_setopt.zsh
source ~/dotfiles/zshrc/00_export.zsh
source ~/dotfiles/zshrc/10_prepare.zsh
source ~/dotfiles/zshrc/20_alias.zsh
source ~/dotfiles/zshrc/30_prompt.zsh
source ~/dotfiles/zshrc/31_zsh_hook.zsh
source ~/dotfiles/zshrc/40_zle_key_bindings.zsh
source ~/dotfiles/zshrc/50_existing_command_hacking.zsh
source ~/dotfiles/zshrc/60_zsh_plugin_manage.zsh

FINISH_TIME=$(epocms_c)
printf "zshrc load finished (%dms).\n" $((FINISH_TIME - START_TIME))

# NOTE: ターミナルのカラーテーマは各ターミナルの設定で実施しています。
# https://github.com/dexpota/kitty-themes.git
# ~/dotfiles/.config/kitty/kitty.conf 等。


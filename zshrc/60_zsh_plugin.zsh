#!/usr/bin/env zsh

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=143'

zcomet load zsh-users/zsh-autosuggestions
zcomet load zsh-users/zsh-completions
zcomet load zsh-users/zsh-history-substring-search
zcomet load junegunn/fzf-bin
zcomet load junegunn/fzf shell/key-bindings.zsh
zcomet load romkatv/zsh-defer

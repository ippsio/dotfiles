#!/usr/bin/env zsh

# Clone zcomet if necessary
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi
source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh

# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=143'
zcomet load zsh-users/zsh-autosuggestions

# zsh-completions
zcomet load zsh-users/zsh-completions

# zsh-history-substring-search
zcomet load zsh-users/zsh-history-substring-search

# fzf-bin
zcomet load junegunn/fzf-bin

init_zsh_defer_inside_fzf_tab() {
  zcomet load romkatv/zsh-defer
  zcomet load Aloxaf/fzf-tab

  zstyle ':completion:*:git-checkout:*' sort false
  zstyle ':completion:*:descriptions' format '[%d]'
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*' menu no
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
  zstyle ':fzf-tab:*' fzf-flags --color='fg:17,bg:240,hl:1,fg+:0,bg+:244' --bind=tab:accept
}

init_key_bindings() {
  zcomet load junegunn/fzf shell/key-bindings.zsh
}

# init_zsh_defer_inside_fzf_tab
init_key_bindings


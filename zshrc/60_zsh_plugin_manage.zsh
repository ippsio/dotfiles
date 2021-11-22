#!/usr/bin/env zsh

source ${ZINIT_ROOT}/bin/zinit.zsh
zinit ice atload"ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
zinit light zsh-users/zsh-autosuggestions

zinit light "zsh-users/zsh-completions"

zinit ice atclone"__zsh_version 4.3" atpull"__zsh_version 4.3"
zinit light "zsh-users/zsh-history-substring-search"

zinit light 'junegunn/fzf-bin'

zinit ice src"shell/key-bindings.zsh"
zinit light "junegunn/fzf"

zinit ice src"shell/completion.zsh"
zinit light "junegunn/fzf"

zinit light "zdharma/fast-syntax-highlighting"

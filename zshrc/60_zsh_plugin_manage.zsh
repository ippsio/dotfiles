#!/usr/bin/env zsh

source ${ZINIT_ROOT}/bin/zinit.zsh
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

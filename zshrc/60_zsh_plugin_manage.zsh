#!/usr/bin/env zsh

### source ${ZPLUG_HOME}/init.zsh
### zplug "zsh-users/zsh-autosuggestions", hook-load: "ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
### zplug 'zsh-users/zsh-completions'
### zplug "mollifier/anyframe"
### zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
### zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
### zplug "junegunn/fzf", use:shell/key-bindings.zsh
### zplug "junegunn/fzf", use:shell/completion.zsh
### zplug "zsh-users/zsh-syntax-highlighting", defer:2
### #zplug "Aloxaf/fzf-tab" # 標準のファイル名、ディレクトリ名補完にfzfをつかってくれるようになる
### zplug check || zplug install
### zplug load #--verbose

source ${ZINIT_ROOT}/bin/zinit.zsh
zinit ice atload"ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
zinit light zsh-users/zsh-autosuggestions

zinit light "zsh-users/zsh-completions"
zinit light "mollifier/anyframe"

zinit ice atclone"__zsh_version 4.3" atpull"__zsh_version 4.3"
zinit light "zsh-users/zsh-history-substring-search"

zinit light 'junegunn/fzf-bin'

zinit ice src"shell/key-bindings.zsh"
zinit light "junegunn/fzf"

zinit ice src"shell/completion.zsh"
zinit light "junegunn/fzf"

#zinit ice wait"2"
#zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zdharma/fast-syntax-highlighting"

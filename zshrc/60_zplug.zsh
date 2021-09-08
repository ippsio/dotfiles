#!/usr/bin/env zsh

source ${ZPLUG_HOME}/init.zsh
source ~/dotfiles/zshrc/50_existing_command_hacking.zsh
zplug "zsh-users/zsh-autosuggestions", hook-load: "ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(my_space_extraction my_tab_completion end-of-line $ZSH_AUTOSUGGEST_CLEAR_WIDGETS)"
zplug 'zsh-users/zsh-completions'
zplug "mollifier/anyframe"
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "Aloxaf/fzf-tab" # 標準のファイル名、ディレクトリ名補完にfzfをつかってくれるようになる
zplug check || zplug install
zplug load #--verbose

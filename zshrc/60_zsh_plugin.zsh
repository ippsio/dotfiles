#!/usr/bin/env zsh

source ${ZINIT_ROOT}/bin/zinit.zsh
zinit light zsh-users/zsh-autosuggestions

zinit light "zsh-users/zsh-completions"

zinit ice atclone"__zsh_version 4.3" atpull"__zsh_version 4.3"
zinit light "zsh-users/zsh-history-substring-search"

zinit light 'junegunn/fzf-bin'

zinit ice src"shell/key-bindings.zsh"
zinit light "junegunn/fzf"

zinit light romkatv/zsh-defer

# zinit ice src"shell/completion.zsh"
# zinit light "junegunn/fzf"

# zinit light "zdharma/fast-syntax-highlighting"
#
zinit light Aloxaf/fzf-tab
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'


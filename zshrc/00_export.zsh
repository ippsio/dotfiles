#!/usr/bin/env zsh
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
#export ZPLUG_HOME=~/.cache/zplug
export ZINIT_ROOT=~/.zinit
export TMUX_PLUGINS=~/.cache/tmux/plugins
export PYENV_ROOT=$HOME/.pyenv
export GOENV_ROOT=$HOME/.goenv
export RBENV_ROOT=$HOME/.rbenv
export NODENV_ROOT=$HOME/.nodenv
#export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

# diff-highlight
DIFF_HIGHLIGHT=$(find /opt/homebrew/Cellar/git -type f -name "diff-highlight" | sort -nr| head -n 1)
export PATH=~/dotfiles/bin:${PYENV_ROOT}/bin:${GOENV_ROOT}/bin:${RBENV_ROOT}/bin:${NODENV_ROOT}/bin:${PATH}:$(dirname ${DIFF_HIGHLIGHT})

# LSCOLORS
# a black      , b red      , c green      , d brown      , e blue      , f magenta      , g cyan      , h light grey
# A black(BOLD), B red(BOLD), C green(BOLD), D brown(BOLD), E blue(BOLD), F magenta(BOLD), G cyan(BOLD), H light grey(BOLD)
# x default foreground or background
#
#   (A bold black, usually shows up as dark grey)
#   (D bold brown, usually shows up as yellow)
#   (H bold light grey; looks like bright white)
#
_C1=gx # 1. directory
_C2=fx # 2. symbolic link
_C3=cx # 3. socket
_C4=dx # 4. pipe
_C5=bx # 5. executable
_C6=dg # 6. block special
_C7=dx # 7. character special
_C8=ab # 8. executable with setuid bit set
_C9=ag # 9. executable with setgid bit set
_C10=ac # 10. directory writable to others, with sticky bit
_C11=ad # 11. directory writable to others, without sticky bit
export LSCOLORS=${_C1}${_C2}${_C3}${_C4}${_C5}${_C6}${_C7}${_C8}${_C9}${_C10}${_C11}

export LANG="ja_JP.UTF-8"
export LC_COLLATE="ja_JP.UTF-8"
export LC_CTYPE="ja_JP.UTF-8"
export LC_MESSAGES="ja_JP.UTF-8"
export LC_MONETARY="ja_JP.UTF-8"
export LC_NUMERIC="ja_JP.UTF-8"
export LC_TIME="ja_JP.UTF-8"
export LC_ALL=

# ---------------------
# FZF
# ---------------------
fzf_default_opts=()
fzf_default_opts+=("--exact --extended --reverse --border --no-sort")
fzf_default_opts+=("--bind change:top")
fzf_default_opts+=("--preview-window=bottom:60%")
fzf_default_opts+=("--color fg:-1,bg:-1,hl:226")
fzf_default_opts+=("--color fg+:120,bg+:20,hl+:226")
fzf_default_opts+=("--color info:108,prompt:48,spinner:108,pointer:168,marker:168,header:191:reverse")
export FZF_DEFAULT_OPTS="${fzf_default_opts[@]}"


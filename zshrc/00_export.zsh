#!/usr/bin/env zsh
# ----------------------------------
# export environmental variables.
# ----------------------------------
export EDITOR=nvim
export ZINIT_ROOT=~/.zinit
export TMUX_PLUGINS=~/.cache/tmux/plugins

# NOTE: diff-highlight を pip install すると ~/.local/bin に配置されます。
DIFF_HIGHLIGHT=$(find /opt/homebrew/Cellar/git -type f -name "diff-highlight" | sort -nr| head -n 1)
export PATH=~/dotfiles/bin:${PATH}:$(dirname ${DIFF_HIGHLIGHT}):~/.local/bin

# LSCOLORS
# a black,
# b red,
# c green,
# d brown,
# e blue,
# f magenta,
# g cyan,
# h light grey
# A black(BOLD),
# B red(BOLD),
# C green(BOLD),
# D brown(BOLD),
# E blue(BOLD),
# F magenta(BOLD),
# G cyan(BOLD),
# H light grey(BOLD)
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
export FZF_DEFAULT_OPTS=\
" --exact"\
" --extended"\
" --reverse"\
" --no-sort"\
" --no-unicode"\
" --color fg:-1"\
" --color bg:-1"\
" --color hl:184"\
" --color fg+:-1:underline"\
" --color bg+:232"\
" --color hl+:184"\
" --color info:108:reverse"\
" --color prompt:193:reverse"\
" --color spinner:108"\
" --color pointer:168:underline"\
" --color marker:168:reverse"\
" --color header:191:reverse"

# " --preview-window=bottom:60%"\

# ---------------------
# mocword
# ---------------------
export MOCWORD_DB=~/.cache/mocword_db/mocword.sqlite

# ---------------------
# Java
# ---------------------
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
# For compilers to find openjdk you may need to set:
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"


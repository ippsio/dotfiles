#!/usr/bin/env zsh
type direnv>/dev/null 2>&1 && eval "$(direnv hook zsh)"
type nodenv>/dev/null 2>&1 && eval "$(nodenv init -)"
type pyenv>/dev/null 2>&1 && eval "$(pyenv init --path)"
type rbenv>/dev/null 2>&1 && eval "$(rbenv init -)"

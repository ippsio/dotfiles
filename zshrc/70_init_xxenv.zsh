#!/usr/bin/env zsh

init_xxenv_with_defer() {
  zsh-defer eval "$(direnv hook zsh)"
  zsh-defer eval "$(goenv init -)"
  zsh-defer eval "$(nodenv init -)"
  zsh-defer eval "$(pyenv init --path)"
  zsh-defer eval "$(rbenv init -)"
}

init_xxenv() {
  eval "$(direnv hook zsh)"
  eval "$(goenv init -)"
  eval "$(nodenv init -)"
  eval "$(pyenv init --path)"
  eval "$(rbenv init -)"
}

if zsh-defer>/dev/null 2>&1; then
  init_xxenv_with_defer
else
  init_xxenv
fi


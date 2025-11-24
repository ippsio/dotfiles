#!/usr/bin/env zsh

nodenv_init_lazy() {
  type nodenv >/dev/null || return 1
  echo "*** nodenv lazy init ***"
  echo 'eval "$(nodenv init -)"'
  eval "$(nodenv init -)"
  unset -f nodenv_init_lazy
  unset -f node
  unset -f npm
  unset -f npx
  command "$@"
}
pyenv_init_lazy() {
  type pyenv >/dev/null || return 1
  echo "*** pyenv lazy init ***"
  echo 'eval "$(pyenv init --path)"'
  eval "$(pyenv init --path)"
  unset -f pyenv_init_lazy
  unset -f pip
  unset -f pip3
  unset -f python
  unset -f python3
  command "$@"
}
rbenv_init_lazy() {
  type rbenv >/dev/null || return 1
  echo "*** rbenv lazy init ***"
  echo 'eval "$(rbenv init -)"'
  eval "$(rbenv init -)"
  unset -f rbenv_init_lazy
  unset -f ruby
  unset -f irb
  unset -f bundle
  command "$@"
}

export PATH="/Users/i/.nodenv/shims:${PATH}"
export NODENV_SHELL=zsh
node() { nodenv_init_lazy node "$@"; }
npm()  { nodenv_init_lazy npm "$@"; }
npx()  { nodenv_init_lazy npx "$@"; }

export PATH="/Users/i/.pyenv/shims:${PATH}"
export PYENV_SHELL=zsh
pip()     { pyenv_init_lazy pip "$@"; }
pip3()    { pyenv_init_lazy pip3 "$@"; }
python()  { pyenv_init_lazy python "$@"; }
python3() { pyenv_init_lazy python3 "$@"; }

export PATH="/Users/i/.rbenv/shims:${PATH}"
export RBENV_SHELL=zsh
ruby()   { rbenv_init_lazy ruby "$@"; }
irb()    { rbenv_init_lazy irb "$@"; }
bundle() { rbenv_init_lazy bundle "$@"; }

type direnv>/dev/null 2>&1 && eval "$(direnv hook zsh)"

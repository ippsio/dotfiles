#!/usr/bin/env zsh
NAME="${0/#$HOME/\$HOME}"
nodenv_init_lazy() {
  type nodenv >/dev/null || return 1
  echo "*** $NAME nodenv lazy init ***"
  printf 'eval "$(nodenv init -)" '
  st=$(epocms)
  eval "$(nodenv init -)"
  et=$(epocms)
  printf "=> %d ms\n" $(( et - st ))
  unset -f nodenv_init_lazy
  unset -f node
  unset -f npm
  unset -f npx
  command "$@"
}
pyenv_init_lazy() {
  type pyenv >/dev/null || return 1
  echo "*** $NAME pyenv lazy init ***"
  printf 'eval "$(pyenv init --path)" '
  st=$(epocms)
  eval "$(pyenv init --path)"
  et=$(epocms)
  printf "=> %d ms\n" $(( et - st ))
  unset -f pyenv_init_lazy
  unset -f pip
  unset -f pip3
  unset -f python
  unset -f python3
  command "$@"
}
rbenv_init_lazy() {
  type rbenv >/dev/null || return 1
  echo "*** $NAME rbenv lazy init ***"
  printf 'eval "$(rbenv init -)" '
  st=$(epocms)
  eval "$(rbenv init -)"
  et=$(epocms)
  printf "=> %d ms\n" $(( et - st ))
  unset -f rbenv_init_lazy
  unset -f bundle
  unset -f gem
  unset -f irb
  unset -f rails
  unset -f rspec
  unset -f ruby
  command "$@"
}

export NODENV_SHELL=zsh
node() { nodenv_init_lazy node "$@"; }
npm()  { nodenv_init_lazy npm "$@"; }
npx()  { nodenv_init_lazy npx "$@"; }

export PYENV_SHELL=zsh
pip()     { pyenv_init_lazy pip "$@"; }
pip3()    { pyenv_init_lazy pip3 "$@"; }
python()  { pyenv_init_lazy python "$@"; }
python3() { pyenv_init_lazy python3 "$@"; }

export RBENV_SHELL=zsh
bundle() { rbenv_init_lazy bundle "$@"; }
gem()    { rbenv_init_lazy gem "$@"; }
irb()    { rbenv_init_lazy irb "$@"; }
rails()  { rbenv_init_lazy rails "$@"; }
rspec()  { rbenv_init_lazy rspec "$@"; }
ruby()   { rbenv_init_lazy ruby "$@"; }

eval "$(direnv hook zsh)"
export PATH="$HOME/.nodenv/shims:${PATH}:$HOME/.pyenv/shims:${PATH}:$HOME/.rbenv/shims:${PATH}"

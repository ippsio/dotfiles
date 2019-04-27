" -----------------------------------------------------
" dein load definition
" -----------------------------------------------------
if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#load_toml('~/dotfiles/nvim/toml/dein.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/nvim/toml/color.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/nvim/toml/toml.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/nvim/toml/rb.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/nvim/toml/py.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/nvim/toml/md.toml', {'lazy': 1})

  "if !has('nvim')
  "  call dein#add('roxma/nvim-yarp')
  "  call dein#add('roxma/vim-hug-neovim-rpc')
  "endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
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
  #let g:dein#auto_recache = 1
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#load_toml('~/.config/nvim/toml/0_shougo.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_file_manage.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_edit_operation.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_vcs.toml', {'lazy': 0})

  call dein#load_toml('~/.config/nvim/toml/1_toml.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_rb.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_py.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_md.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_json.toml', {'lazy': 1})

  if has('nvim')
    call dein#remote_plugins()
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

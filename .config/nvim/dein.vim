" -----------------------------------------------------
" dein load definition
" -----------------------------------------------------
if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  for toml_lazy0 in [
    \ '~/dotfiles/.config/nvim/toml/0_ddc.toml',
    \ '~/dotfiles/.config/nvim/toml/0_fzf.toml',
    \ '~/dotfiles/.config/nvim/toml/0_cursor.toml',
    \ '~/dotfiles/.config/nvim/toml/0_visual.toml',
    \ '~/dotfiles/.config/nvim/toml/0_statusline.toml',
    \ '~/dotfiles/.config/nvim/toml/0_git.toml',
    \ '~/dotfiles/.config/nvim/toml/0_filemanage.toml',
    \ '~/dotfiles/.config/nvim/toml/0_syntax.toml',
    \ '~/dotfiles/.config/nvim/toml/0_browser.toml',
    \ '~/dotfiles/.config/nvim/toml/0_misc.toml',
    \ ]
    call dein#load_toml(toml_lazy0, {'lazy': 0})
  endfor

  for toml_lazy1 in [
    \ '~/dotfiles/.config/nvim/toml/1_lsp.toml',
    \ '~/dotfiles/.config/nvim/toml/1_syntax.toml',
    \ '~/dotfiles/.config/nvim/toml/1_linter.toml',
    \ '~/dotfiles/.config/nvim/toml/1_rb.toml',
    \ '~/dotfiles/.config/nvim/toml/1_typescript.toml',
    \ '~/dotfiles/.config/nvim/toml/1_py.toml',
    \ ]
    call dein#load_toml(toml_lazy1, {'lazy': 1})
  endfor

  if has('nvim')
    call dein#remote_plugins()
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

call dein#recache_runtimepath()

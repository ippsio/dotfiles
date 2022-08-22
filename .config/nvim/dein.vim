if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  let ar = []
  call add(ar, '~/dotfiles/.config/nvim/toml/0_fzf.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_cursor.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_visual.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_statusline.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_git.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_filemanage.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_syntax.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_browser.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/0_misc.toml')
  for toml_lazy0 in ar
    call dein#load_toml(toml_lazy0, {'lazy': 0})
  endfor

  let ar = []
  call add(ar, '~/dotfiles/.config/nvim/toml/1_ddc.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_lsp.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_syntax.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_linter.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_rb.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_typescript.toml')
  call add(ar, '~/dotfiles/.config/nvim/toml/1_py.toml')
  for toml_lazy1 in ar
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

" call dein#recache_runtimepath()

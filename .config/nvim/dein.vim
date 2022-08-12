" -----------------------------------------------------
" dein load definition
" -----------------------------------------------------
if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

" toml上、deinのプラグイン定義を削除したのに実際のプラグインが消えてないよ、って場合、
" call dein#recache_runtimepath() を実行するとキャッシュが削除される。
" キャッシュを削除した後はvimを再起動しましょう。
" call dein#recache_runtimepath()
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " 'lazy': 0
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_ddc.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_fzf.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_cursor.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_visual.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_statusline.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_git.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_diff.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_filemanage.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_syntax.toml', {'lazy': 0})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_misc.toml', {'lazy': 0})

  " 'lazy': 1
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_lsp.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_syntax.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_linter.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_rb.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_typescript.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/1_py.toml', {'lazy': 1})
  call dein#load_toml('~/dotfiles/.config/nvim/toml/0_browser.toml', {'lazy': 0})

  if has('nvim')
    call dein#remote_plugins()
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


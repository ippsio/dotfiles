if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  let lazy0_ar = [
    \ '~/dotfiles/.config/nvim/toml/git_vim-fugitive.toml',
    \ '~/dotfiles/.config/nvim/toml/git_vim-gitgutter.toml',
    \ '~/dotfiles/.config/nvim/toml/git_conflict-marker.toml',
    \ '~/dotfiles/.config/nvim/toml/statusline_lightline.toml',
    \ '~/dotfiles/.config/nvim/toml/syntax_nvim-treesitter.toml',
    \ '~/dotfiles/.config/nvim/toml/visual_vim-cursorword.toml',
    \ '~/dotfiles/.config/nvim/toml/visual_vim-parenmatch.toml',
    \ '~/dotfiles/.config/nvim/toml/visual_vim-insert-linenr.toml',
    \ '~/dotfiles/.config/nvim/toml/visual_vim-indent-guides.toml',
    \ '~/dotfiles/.config/nvim/toml/visual_vim-trailing-whitespace.toml',
    \ '~/dotfiles/.config/nvim/toml/cursor_accelerated-jk.toml',
    \ '~/dotfiles/.config/nvim/toml/fzf.toml',
    \ '~/dotfiles/.config/nvim/toml/vimproc.toml',
    \ '~/dotfiles/.config/nvim/toml/signature_echodoc.toml',
    \ '~/dotfiles/.config/nvim/toml/diff_clip_diff.toml',
    \]
  for toml_file in lazy0_ar
    call dein#load_toml(toml_file, {'lazy': 0})
  endfor

  let lazy1_ar = [
    \ '~/dotfiles/.config/nvim/toml/0_filemanage.toml',
    \ '~/dotfiles/.config/nvim/toml/quickrun.toml',
    \ '~/dotfiles/.config/nvim/toml/snippet.toml',
    \ '~/dotfiles/.config/nvim/toml/0_misc.toml',
    \ '~/dotfiles/.config/nvim/toml/doc_vimdoc-ja.toml',
    \ '~/dotfiles/.config/nvim/toml/1_ddc.toml',
    \ '~/dotfiles/.config/nvim/toml/1_lsp.toml',
    \ '~/dotfiles/.config/nvim/toml/1_syntax.toml',
    \ '~/dotfiles/.config/nvim/toml/1_linter.toml',
    \ '~/dotfiles/.config/nvim/toml/1_rb.toml',
    \ '~/dotfiles/.config/nvim/toml/1_typescript.toml',
    \ '~/dotfiles/.config/nvim/toml/1_py.toml',
    \]
  for toml_file in lazy1_ar
    call dein#load_toml(toml_file, {'lazy': 1})
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


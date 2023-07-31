if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  let array = []
  call insert(array, '~/.config/nvim/toml/git_vim-fugitive.toml')
  call insert(array, '~/.config/nvim/toml/git_vim-gitgutter.toml')
  call insert(array, '~/.config/nvim/toml/git_conflict-marker.toml')
  call insert(array, '~/.config/nvim/toml/statusline_lightline.toml')
  call insert(array, '~/.config/nvim/toml/visual_vim-cursorword.toml')
  call insert(array, '~/.config/nvim/toml/visual_vim-parenmatch.toml')
  call insert(array, '~/.config/nvim/toml/visual_vim-insert-linenr.toml')
  call insert(array, '~/.config/nvim/toml/visual_vim-indent-guides.toml')
  call insert(array, '~/.config/nvim/toml/visual_vim-trailing-whitespace.toml')
  call insert(array, '~/.config/nvim/toml/cursor_accelerated-jk.toml')
  call insert(array, '~/.config/nvim/toml/fzf.toml')
  call insert(array, '~/.config/nvim/toml/vimproc.toml')
  call insert(array, '~/.config/nvim/toml/diff_clip_diff.toml')
  call insert(array, '~/.config/nvim/toml/syntax_nvim-treesitter.toml')
  for toml_file in array
    call dein#load_toml(toml_file, {'lazy': 0})
  endfor

  let array = []
  call insert(array, '~/.config/nvim/toml/0_filemanage.toml')
  "call insert(array, '~/.config/nvim/toml/0_misc.toml')
  call insert(array, '~/.config/nvim/toml/doc_vimdoc-ja.toml')
  call insert(array, '~/.config/nvim/toml/1_syntax.toml')
  call insert(array, '~/.config/nvim/toml/1_linter.toml')
  call insert(array, '~/.config/nvim/toml/1_rb.toml')
  call insert(array, '~/.config/nvim/toml/1_typescript.toml')
  call insert(array, '~/.config/nvim/toml/1_py.toml')
  call insert(array, '~/.config/nvim/toml/git_vim-gf-diff.toml')
  call insert(array, '~/.config/nvim/toml/1_lsp.toml')
  call insert(array, '~/.config/nvim/toml/ddc.toml')
  call insert(array, '~/.config/nvim/toml/ddc_source.toml')
  call insert(array, '~/.config/nvim/toml/ddc_filter.toml')
  call insert(array, '~/.config/nvim/toml/ddc_ui.toml')
  for toml_file in array
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


if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  let l0 = []
  call insert(l0, '~/dotfiles/.config/nvim/toml/git_vim-fugitive.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/git_vim-gitgutter.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/git_conflict-marker.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/statusline_lightline.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/syntax_nvim-treesitter.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/visual_vim-cursorword.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/visual_vim-parenmatch.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/visual_vim-insert-linenr.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/visual_vim-indent-guides.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/visual_vim-trailing-whitespace.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/cursor_accelerated-jk.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/fzf.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/vimproc.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/signature_echodoc.toml')
  call insert(l0, '~/dotfiles/.config/nvim/toml/diff_clip_diff.toml')
  for toml_file in l0
    call dein#load_toml(toml_file, {'lazy': 0})
  endfor

  let l1 = []
  call insert(l1, '~/dotfiles/.config/nvim/toml/0_filemanage.toml')
  " call insert(l1, '~/dotfiles/.config/nvim/toml/0_misc.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/doc_vimdoc-ja.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/ddc.toml')
  " call insert(l1, '~/dotfiles/.config/nvim/toml/ddc_source.toml')
  "call insert(l1, '~/dotfiles/.config/nvim/toml/ddc_filter.toml')
  " call insert(l1, '~/dotfiles/.config/nvim/toml/ddc_ui.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_lsp.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_syntax.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_linter.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_rb.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_typescript.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/1_py.toml')
  call insert(l1, '~/dotfiles/.config/nvim/toml/git_vim-gf-diff.toml')
  for toml_file in l1
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


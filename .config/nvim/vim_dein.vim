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
  "call dein#add('vim-jp/vimdoc-ja')

  " lazy0: どんなfiletypeでも動く
  " 一軍
  call dein#load_toml('~/.config/nvim/toml/0_command_altercmd.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_format_sqlutilities.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_fzf.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_qfixgrep.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-anzu.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-easymotion.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-over.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-ripgrep.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_filemanage_nerdtree.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_filemanage_denite.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-indent-guides.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_rainbow_parentheses_vim.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-insert-linenr.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-trailing-whitespace.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_statusline_lightline.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_completion_coc.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_completion_deoplete_nvim.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_completion_vim-surround.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_completion_vim-endwise.toml'.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_vim-messenger.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_tig-explorer.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_vim-fugitive.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_vim-gitgutter.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_diff_clip_diff.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_memo_qfixhown.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_memo_vim-cheatsheet.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_vimdoc_vimdoc-ja.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_syntax_context_filetype.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_syntax_vim-precious.toml', {'lazy': 0})

  " 二軍
  "call dein#load_toml('~/.config/nvim/toml/0_pane_vim-choosewin.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_buffer_minibufexpl.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_filemanage_mru.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_visual_indentline.toml', {'lazy': 0})

  " lazy1: 特定のfiletypeでのみ動く
  " 一軍
  call dein#load_toml('~/.config/nvim/toml/1_toml.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_rb.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_md.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_json.toml', {'lazy': 1})
  " 二軍
  "call dein#load_toml('~/.config/nvim/toml/1_py.toml', {'lazy': 1})

  if has('nvim')
    call dein#remote_plugins()
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

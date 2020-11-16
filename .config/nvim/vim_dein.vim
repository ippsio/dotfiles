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

  " お試し
  call dein#load_toml('~/.config/nvim/toml/0_tasting_now.toml', {'lazy': 0})

  " lazy0: どんなfiletypeでも動く
  " 一軍
  call dein#load_toml('~/.config/nvim/toml/0_command_altercmd.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_format_sqlutilities.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_fzf.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_qfixgrep.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-anzu.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-easymotion.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_search_vim-ripgrep.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_filemanage_nerdtree.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-indent-guides.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-insert-linenr.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_visual_vim-trailing-whitespace.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_statusline_lightline.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_completion_coc.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_completion_vim-surround.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_vim-fugitive.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_git_vim-gitgutter.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_diff_clip_diff.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_vimdoc_vimdoc-ja.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_syntax_context_filetype.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/toml/0_textobj_vim-expand-region.toml', {'lazy': 0})
  "
  " vim-preciousを使っている時、
  " なんかtomlを編集していると、エラーが出る端末があるのよね。うまくいく端末もあるんだけど、不思議。
  " function precious#context_filetype[2]..275[5]..context_filetype#get_filetype[2]..context_filetype#get[3]..<SNR>109_get_nest[1]..<SNR>109_get_context[20]..<SNR>109_search_range
  " の処理中にエラーが検出されました:
  " 行   28:
  " E65: 不正な後方参照です
  " call dein#load_toml('~/.config/nvim/toml/0_syntax_vim-precious.toml', {'lazy': 0})

  " 二軍
  "call dein#load_toml('~/.config/nvim/toml/0_pane_vim-choosewin.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_buffer_minibufexpl.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_filemanage_mru.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_visual_indentline.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_search_vim-over.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_datetime_current_datetime.vim.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_ghpr-blame_vim.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_filemanage_denite.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_visual_rainbow_parentheses_vim.toml', {'lazy': 0})
  "call dein#load_toml('~/.config/nvim/toml/0_completion_deoplete_nvim.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_git_vim-messenger.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_memo_qfixhown.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_memo_vim-cheatsheet.toml', {'lazy': 0})
  " vim-endwise" cocの保管時に暴発
  call dein#load_toml('~/.config/nvim/toml/0_completion_vim-endwise.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_git_tig-explorer.toml', {'lazy': 0})
  " call dein#load_toml('~/.config/nvim/toml/0_search_any_jump.toml', {'lazy': 0})

  " lazy1: 特定のfiletypeでのみ動く
  " 一軍
  call dein#load_toml('~/.config/nvim/toml/1_toml.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_rb.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_md.toml', {'lazy': 1})
  call dein#load_toml('~/.config/nvim/toml/1_json.toml', {'lazy': 1})
  " 二軍
  "call dein#load_toml('~/.config/nvim/toml/1_py.toml', {'lazy': 1})
  "call dein#load_toml('~/.config/nvim/toml/1_git_vim-gf-diff.toml', {'lazy': 1})

  if has('nvim')
    call dein#remote_plugins()
  endif
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

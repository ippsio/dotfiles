runtime! vars.vim
runtime! settings.vim
runtime! remaps.vim
runtime! abbrevs.vim
runtime! autocmds.vim
runtime! jetpack.vim
runtime! rc/functions/Hi.vim
colorscheme sorbet
augroup InitvimHi
  autocmd!
  "autocmd VimEnter * hi Search guibg=#cc2211
  "autocmd VimEnter * hi CurSearch guibg=#ff4455
augroup END

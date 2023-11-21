if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

nnoremap <silent> <space>a :Git blame<CR>
augroup FugitiveAutocmd
  autocmd!
  " fugitive の blame だけになった時、quitする。
  autocmd WinEnter * if winnr('$') == 1 && expand('%p') =~ '.fugitiveblame' | quit | endif
augroup END


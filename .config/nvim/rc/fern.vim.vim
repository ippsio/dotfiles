" 隠しファイルを表示
let g:fern#default_hidden=1

" ファイルツリーを開くコマンドを設定
nnoremap <silent> sf :Fern %:h -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> F :Fern %:h -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> <C-n> :Fern %:h -reveal=% -drawer -toggle -width=60<CR>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  " nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)

  nmap <buffer> <C-l> <C-w>l
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END


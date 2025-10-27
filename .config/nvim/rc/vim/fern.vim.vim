" 隠しファイルを表示
let g:fern#default_hidden=1

" ファイルツリーを開く
nnoremap <silent> <C-n> :Fern .   -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> ,     :Fern %:h -reveal=% -drawer -toggle -width=60<CR>

function! s:init_fern() abort
  nmap <buffer> <C-l> <C-w>l
  nmap <buffer> h <Plug>(fern-action-leave)
  nmap <buffer> <Left> <Plug>(fern-action-leave)
  nmap <buffer> <Right> <Plug>(fern-action-open-or-expand)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd WinEnter * if &filetype != 'fern' | exec 'FernDo close -stay' | endif
augroup END

" 隠しファイルを表示
let g:fern#default_hidden=1

" ファイルツリーを開く
nnoremap <silent> <C-n> :Fern . -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> , :Fern %:h -reveal=% -drawer -toggle -width=60<CR>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  " nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)

  nmap <buffer> <C-l> <C-w>l
endfunction

function! CommonParentDirectory()
  let l:current_dir = getcwd()
  let l:file_dir = expand('%:p:h')

  while l:file_dir !=# l:current_dir
    if stridx(l:current_dir, l:file_dir) == 0
      exec 'Fern ' . l:file_dir . ' -reveal=% -drawer -toggle -width=60'
      return
    endif
    let l:file_dir = fnamemodify(l:file_dir, ':h')
  endwhile

  exec 'Fern ' . l:current_dir . ' -reveal=% -drawer -toggle -width=60'
  "return l:current_dir
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd WinEnter * if &filetype != 'fern' | exec 'FernDo close -stay' | endif
augroup END

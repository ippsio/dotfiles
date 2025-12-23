" 隠しファイルを表示
let g:fern#default_hidden=1
let g:fern#renderer = "nerdfont"

function! s:find_project_root() abort
  let l:git_dir = finddir('.git', '.;')
  return l:git_dir != '' ? fnamemodify(l:git_dir, ':h') : '.'
endfunction

nnoremap <silent> <C-n> :<C-u>execute 'Fern ' . <SID>find_project_root() . ' -reveal=' . expand('%:p') . ' -drawer -toggle -width=60'<CR>
nnoremap <silent> ,     :<C-u>execute 'Fern ' . <SID>find_project_root() . ' -reveal=' . expand('%:p') . ' -drawer -toggle -width=60'<CR>

function! s:init_fern() abort
  nmap <buffer> <C-l> <C-w>l
  nmap <buffer> <Left> <Plug>(fern-action-leave)
  nmap <buffer> <Right> <Plug>(fern-action-open-or-expand)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
  autocmd WinEnter * if &filetype != 'fern' | exec 'FernDo close -stay' | endif
augroup END

"if !jetpack#tap(expand('<script>:t:r'))
"  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
"endif

" 隠しファイルを表示
let g:fern#default_hidden=1

" ファイルツリーを開くコマンドを設定
nnoremap <silent> sf :Fern %:h -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> F :Fern %:h -reveal=% -drawer -toggle -width=60<CR>
nnoremap <silent> <C-n> :Fern %:h -reveal=% -drawer -toggle -width=60<CR>
function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END


if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

set updatetime=250
set signcolumn=yes

" 変更マーク
let g:gitgutter_sign_added              = 'A'
let g:gitgutter_sign_modified           = 'M'
let g:gitgutter_sign_removed            = 'X'
let g:gitgutter_sign_removed_first_line = 'X1'
let g:gitgutter_sign_removed_above_and_below = 'XC'
let g:gitgutter_sign_modified_removed   = 'MX'

"" 変更マークのハイライト
"hi SignColumn             ctermbg=none
hi GitGutterAdd           cterm=standout " an added line
hi GitGutterChange        cterm=standout " a changed line
hi GitGutterDelete        cterm=standout " at least one removed line
hi GitGutterChangeDelete  cterm=standout " a changed line followed by at least one removed line

" 行ハイライトは結構見にくいと感じたので、コメントアウト
" 起動時に差分行の行ハイライトを自動的に有効にする
" let g:gitgutter_highlight_lines = 1

" 行番号のハイライト
" let g:gitgutter_highlight_linenrs = 1

function! s:UpdateMergeBase()
  if $GIT_MERGE_BASE != ""
    let g:gitgutter_diff_base = $GIT_MERGE_BASE
  endif
  GitGutter
endfunction

augroup GitGutter
  autocmd!
  " 何かバッファを開いたら、gitgutterのサイン表示に利用するgitの比較元ハッシュを更新する
  autocmd BufEnter * call s:UpdateMergeBase()
augroup END


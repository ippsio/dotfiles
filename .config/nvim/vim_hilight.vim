" hi {group-name} {key}={arg}
"  - group-nameの一覧を見る方法
"    - :help group-name
"
" 設定できる色の一覧を見たい場合
" :so $VIMRUNTIME/syntax/colortest.vim
"
" 現在設定している色の確認（結構時間かかりまっせ）
" :so $VIMRUNTIME/syntax/hitest.vim

" カーソル行
hi CursorLine term=reverse cterm=none ctermbg=237
" カーソル自体の色は、iTerm2等のターミナルの設定であるため、コメントアウト
"hi Cursor ctermbg=1 ctermfg=240

" 補完ポップアップ
hi Pmenu ctermbg=7
hi PmenuSel ctermbg=255
hi PmenuSbar ctermbg=2
hi PmenuThumb ctermbg=4

" 検索単語
hi Search ctermbg=22 ctermfg=255

" フォーカスのないウインドウ
hi NormalNC ctermbg=0 ctermfg=240

" コメント
hi Comment ctermbg=17

" カーソル下のhighlight情報を表示する {{{
function! s:syn_attr(transparent, str)
  let s = synID(line("."), col("."), 1)
  if a:transparent
    let s = synIDtrans(s)
  endif
  echo "[" . a:str . "]"
  echo "hi ".synIDattr(s,"name")." ctermfg=".synIDattr(s,"fg","cterm")." ctermbg=".synIDattr(s,"bg","cterm")." guifg=".synIDattr(s,"fg","gui")." guibg=".synIDattr(s,"bg","gui")
  echo " "
endfunction

function! s:syn_info()
  echo "Hi info under the cursor.."
  let s:hoge = s:syn_attr(0, "highlight")
  let s:hoge = s:syn_attr(1, "highlight group")
endfunction

command! Hiinfo call s:syn_info()

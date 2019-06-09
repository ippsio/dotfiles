" hi {group-name} {key}={arg}
"  - group-nameの一覧を見る方法
"    - :help group-name
"
" 設定できる色の一覧を見たい場合
" :so $VIMRUNTIME/syntax/colortest.vim
"
" 現在設定している色の確認（結構時間かかりまっせ）
" :so $VIMRUNTIME/syntax/hitest.vim

if has('nvim')
  set termguicolors
endif

" カーソル行
hi CursorLine term=reverse cterm=none ctermbg=237
" カーソル自体の色は、iTerm2等のターミナルの設定であるため、コメントアウト hi Cursor ctermbg=1 ctermfg=240

hi Statement guibg=111

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
hi Comment ctermbg=17 ctermfg=14 guibg=#002233 guifg=#00ffaa

" 変数、文字列
hi Constant ctermfg=161 guifg=#ffaaaa guibg=#330000

" 行番号
hi LineNr ctermfg=243 guifg=#ffcfbb

"hi Function guifg=#ffff00 guibg=#444400
hi Statement guifg=#ffff00

" カーソル下のhighlight情報を表示する {{{
function! s:part(s, fgbg, type)
  let l:attr = synIDattr(a:s, a:fgbg, a:type)
  return l:attr ? " " . a:type . a:fgbg . "=" . l:attr : ""
endfunction

function! s:attr(transparent)
  let l:s = synID(line("."), col("."), 1)
  let l:s = a:transparent ? synIDtrans(l:s) : l:s
  return synIDattr(l:s,"name").s:part(l:s, "fg", "cterm").s:part(l:s, "bg", "cterm").s:part(l:s, "fg", "gui").s:part(l:s, "bg", "gui")
endfunction

function! s:syn_info()
  let l:prev_attr = ""
  let l:curr_attr = ""
  for i in [0, 1]
    let l:curr_attr = s:attr(i)
    if l:curr_attr == l:prev_attr
      :break
    endif
    echo "hi " . l:curr_attr
    let l:prev_attr = l:curr_attr
  endfor
endfunction

command! Hiinfo call s:syn_info()


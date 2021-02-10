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
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" 背景色
"hi Normal guibg=#222622
"hi NormalNC guibg=#000000

" 背景色により、現在カーソルのあるウインドウをわかりやすくする。
"augroup ChangeBackground
"  autocmd!
"  "" 背景色(カレントウインドウ)
"  autocmd FocusGained * hi Normal guibg=#222622
"  autocmd FocusLost   * hi Normal guibg=default
"augroup END

" カーソル行
hi CursorLine term=reverse cterm=none ctermbg=237
" カーソル自体の色は、iTerm2等のターミナルの設定であるため、コメントアウト hi Cursor ctermbg=1 ctermfg=240

hi Statement guibg=111

" 補完ポップアップ
hi Pmenu ctermbg=7 guibg=#333333
hi PmenuSel ctermbg=255 guibg=#aaaaaa guifg=#333333
hi PmenuSbar ctermbg=2 guibg=#222222
hi PmenuThumb ctermbg=4 guibg=#ffffff

" 検索単語
"hi IncSearch guibg=#882200 guifg=#ff22ff
hi Search    guibg=#882200 guifg=#ff22ff

" フォーカスのないウインドウ
hi NormalNC ctermbg=0 ctermfg=240

" コメント
hi Comment guifg=#00ddff guibg=#004a4a

" 変数、文字列
hi Constant guifg=#ffaaaa guibg=#330000

" ruby
hi rubySymbol guifg=#ff5555 guibg=#440000
hi rubyString guifg=#7777ff guibg=#000044
hi rubyTodo guibg=#663300

" 行番号
hi LineNr guifg=#006666

" directory
hi Directory guifg=#88ccff guibg=#000055

hi Type guibg=#004433 guifg=#00ff33
hi Visual guibg=#2211aa

" markdown
hi markdownH1          guibg=#cc2299 guifg=#ffff66
hi markdownH1Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownH2          guibg=#cc2299 guifg=#ffff66
hi markdownH2Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownH3          guibg=#cc2299 guifg=#ffff66
hi markdownH3Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownH4          guibg=#cc2299 guifg=#ffff66
hi markdownH4Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownH5          guibg=#cc2299 guifg=#ffff66
hi markdownH5Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownCode          guibg=#333333 guifg=#cccccc
hi markdownCodeDelimiter guibg=#222222 guifg=#cccccc

hi markdownListMarker guibg=#456789 guifg=#ffff00 gui=bold
hi markdownError guibg=#222622

"hi Function guifg=#ffff00 guibg=#444400
hi Statement guifg=#ffff00

" vimdiffの色設定
hi DiffAdd     guifg=#00ff33 guibg=#004433
hi DiffAdded   guifg=#00ffdd guibg=#004433
hi DiffRemoved guifg=#ff7766 guibg=#440000
hi DiffChange  guifg=#aaaa00 guibg=#666600
hi DiffText    guifg=#ff9999 guibg=#660000
hi DiffDelete  guifg=#666666 guibg=#000000

" qfixgrep
hi qfFileName guifg=#00fff3 guibg=#004433
hi QuickFixLine guibg=#002240 guifg=#099999
" hi qfLineNr   guifg=#00ff33 guibg=#004433

" MiniBufExpl Colors
hi MBENormal               guifg=#808080 guibg=fg
hi MBEChanged              guifg=#ffcc00 guibg=fg
hi MBEVisibleNormal        guifg=#5DC2D6 guibg=fg
hi MBEVisibleChanged       guifg=#ffcc00 guibg=fg
hi MBEVisibleActiveNormal  guifg=#ff9900 guibg=#ff5500 gui=bold
hi MBEVisibleActiveChanged guifg=#F1266F guibg=fg

" カーソル下のhighlight情報を表示する
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


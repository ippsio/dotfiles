" hi {group-name} {key}={arg}
"  - group-nameの一覧を見る方法
"    - :help group-name
"
" 設定できる色の一覧を見たい場合
" :so $VIMRUNTIME/syntax/colortest.vim
"
" 現在設定している色の確認（結構時間かかりまっせ）
" :so $VIMRUNTIME/syntax/hitest.vim

" if has('nvim')
"   set termguicolors
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif

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
hi CursorLine cterm=NONE ctermfg=NONE ctermbg=NONE
" カーソル自体の色は、iTerm2等のターミナルの設定であるため、コメントアウト
" hi Cursor ctermbg=1 ctermfg=240

" 補完ポップアップ
hi Pmenu ctermfg=195 ctermbg=236
hi PmenuSel ctermfg=255 ctermbg=33
hi PmenuSbar ctermbg=190
hi PmenuThumb ctermbg=27

" コード規約上120文字な言語があったりするので、その目安に線を引く
" let &colorcolumn=join(range(121,121),",")
hi ColorColumn ctermbg=235

" 検索単語
"hi IncSearch guibg=#882200 guifg=#ff22ff
hi Search ctermbg=89 ctermfg=201

" フォーカスのないウインドウ
hi NormalNC ctermfg=251

" コメント
hi Comment ctermbg=23 ctermfg=123
hi vimLineComment ctermbg=23 ctermfg=123
hi vimCommentString ctermbg=23 ctermfg=123
hi vimCommentTitle ctermbg=23
hi vimCommentTitleLeader ctermbg=23

" 変数、文字列
"hi Constant ctermfg=168 cterm=bold
"hi Constant ctermfg=168
hi Constant ctermfg=105

hi PreProc ctermfg=170

" ruby
hi rubySymbol ctermbg=52 ctermfg=196
hi rubyString ctermbg=232 ctermfg=69
hi rubyTodo ctermbg=94

" 行番号
hi LineNr guifg=#006666 ctermfg=23

" directory
"hi Directory ctermbg=16 ctermfg=75 cterm=bold
hi Directory ctermbg=16 ctermfg=75

"hi Type ctermbg=16 ctermfg=118 cterm=bold
"hi Type ctermbg=16 ctermfg=118
hi Type ctermbg=16 ctermfg=48
"hi Visual ctermbg=0 ctermbg=226
"hi Visual ctermbg=60
hi Visual ctermfg=220 ctermbg=237

" markdown
" hi markdownH1          guibg=#cc2299 guifg=#ffff66
" hi markdownH1Delimiter guibg=#ff2299 guifg=#ffff00
" hi markdownH2          guibg=#cc2299 guifg=#ffff66
" hi markdownH2Delimiter guibg=#ff2299 guifg=#ffff00
" hi markdownH3          guibg=#cc2299 guifg=#ffff66
" hi markdownH3Delimiter guibg=#ff2299 guifg=#ffff00
" hi markdownH4          guibg=#cc2299 guifg=#ffff66
" hi markdownH4Delimiter guibg=#ff2299 guifg=#ffff00
" hi markdownH5          guibg=#cc2299 guifg=#ffff66
" hi markdownH5Delimiter guibg=#ff2299 guifg=#ffff00
hi markdownCode          guibg=#333333 guifg=#cccccc ctermbg=236 ctermfg=255
hi markdownCodeDelimiter guibg=#222222 guifg=#cccccc ctermbg=88 ctermfg=211

hi markdownListMarker guibg=#456789 guifg=#ffff00 gui=bold
hi markdownError guibg=#222622

"hi Function guifg=#ffff00 guibg=#444400
" hi Statement guifg=#ffff00 ctermfg=226 cterm=bold
hi Statement ctermfg=226

" vimdiffの色設定
hi DiffAdd     ctermfg=123 ctermbg=023
hi DiffAdded   ctermfg=123 ctermbg=023
hi DiffRemoved ctermfg=210 ctermbg=052
hi DiffChange  ctermfg=210 ctermbg=052
hi DiffText    ctermfg=168 ctermbg=125
hi DiffDelete  ctermfg=238 ctermbg=234

" qfixgrep
hi qfFileName ctermfg=118
hi QuickFixLine ctermfg=222 ctermbg=69

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

command! Hi call s:syn_info()
command! Hiinfo call s:syn_info()


"set notermguicolors
" if has('nvim')
"   set termguicolors
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" endif

" カーソル行
hi CursorLine cterm=underline ctermbg=239

" 補完ポップアップ
hi Pmenu ctermfg=195 ctermbg=237
hi PmenuSel ctermfg=255 ctermbg=33
hi PmenuSbar ctermbg=190
hi PmenuThumb ctermbg=27

" コード規約上120文字な言語があったりするので、その目安に線を引く
hi ColorColumn ctermbg=235 cterm=NONE

" 検索単語
hi Search ctermbg=89 ctermfg=208

" フォーカスのないウインドウ
hi NormalNC ctermfg=251

" コメント
hi Comment ctermbg=236 ctermfg=6
hi vimLineComment ctermbg=236 ctermfg=6
hi link vimCommentString Comment
hi vimCommentTitle ctermbg=23
hi vimCommentTitleLeader ctermbg=23
"hi pythonTripleQuotes ctermbg=1

" 変数、文字列
hi Constant ctermfg=105
hi PreProc ctermfg=170
hi String ctermfg=75

" ruby
hi rubySymbol ctermbg=0 ctermfg=170
hi link rubyString String
hi rubyTodo ctermbg=94

" 行番号
hi LineNr ctermfg=136
" directory
hi Directory ctermbg=16 ctermfg=75

hi Type ctermbg=16 ctermfg=48
hi Visual ctermfg=220 ctermbg=237
" markdown
hi markdownCode          ctermbg=236 ctermfg=255
hi markdownCodeDelimiter ctermbg=88 ctermfg=211
"hi markdownListMarker guibg=#456789 guifg=#ffff00 gui=bold
"hi markdownError guibg=#222622

hi Statement ctermfg=178

" vimdiffの色設定
hi DiffAdd     ctermfg=123 ctermbg=031
hi DiffAdded   ctermfg=123 ctermbg=031
hi DiffRemoved ctermfg=210 ctermbg=240
hi DiffChange  ctermfg=210 ctermbg=240
hi DiffDelete  ctermfg=238 ctermbg=99
hi DiffText ctermfg=168 ctermbg=117

" rst
hi rstSections ctermfg=224 ctermbg=198

" man
hi manHeader ctermfg=224 ctermbg=198

" qfixgrep
hi qfFileName ctermfg=118
hi QuickFixLine ctermfg=222 ctermbg=69

" vimContinue
hi vimContinue ctermfg=70 ctermbg=54
hi vimOperParen ctermfg=222
hi vimUserFunc ctermfg=10

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


set notermguicolors
"if has('nvim')
"  set termguicolors
"  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"endif

" カーソル行
hi CursorLine cterm=underline

"" 補完ポップアップ
hi Pmenu       ctermfg=253  ctermbg=236
hi PmenuSel    ctermfg=237  ctermbg=253 cterm=underline
hi PmenuSbar   ctermfg=237  ctermbg=253 cterm=underline

" コード規約上120文字な言語があったりするので、その目安に線を引く
hi ColorColumn ctermbg=235 cterm=NONE

" 検索単語
hi Search     ctermfg=NONE ctermbg=211

" コメント
hi Comment        ctermfg=244 ctermbg=NONE
hi Todo           ctermfg=244 ctermbg=NONE cterm=reverse

" 変数、文字列
hi Constant   ctermfg=95   ctermbg=253
hi PreProc    ctermfg=134  ctermbg=NONE
hi String     ctermfg=243  ctermbg=NONE
hi Function   ctermfg=NONE ctermbg=252
hi Special    ctermfg=102  ctermbg=NONE
hi Identifier ctermfg=245  ctermbg=NONE

" 行番号
hi LineNr    ctermfg=238 ctermbg=NONE
" directory
hi Directory ctermfg=242 ctermbg=NONE

hi Type    ctermfg=100 ctermbg=NONE cterm=bold
hi Visual  ctermfg=NONE ctermbg=NONE cterm=reverse
hi Statement ctermfg=172 ctermbg=NONE

" vimdiffの色設定
hi DiffAdd     ctermfg=203  ctermbg=NONE
hi DiffAdded   ctermfg=203  ctermbg=NONE
hi DiffRemoved ctermfg=063  ctermbg=NONE
hi DiffChange  ctermfg=063  ctermbg=NONE
hi DiffDelete  ctermfg=NONE ctermbg=250
hi DiffText    ctermfg=18 ctermbg=NONE

" vimContinue
hi vimContinue ctermfg=70 ctermbg=54
hi vimOperParen ctermfg=222
hi vimUserFunc ctermfg=10

hi MatchParen ctermfg=56 ctermbg=NONE

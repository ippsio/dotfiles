" -----------------------------------------------------
" 操作設定
" -----------------------------------------------------

" set pasteすると貼り付けモードとなり、inoremapが効かなくなり、jjをESCと見なせなくなるため、コメントアウト
" set paste

" " インサートモードでbackspaceを有効に
" set backspace=indent,eol,start
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>
" ビジュアルモードの選択範囲を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" vを二回で行末まで選択
vnoremap v $h

" スペース２度押しでカーソル下にある単語をハイライト
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" ウィンドウ操作にsキーが都合が良いので、既存のsを塞ぐ
nnoremap s <Nop>

" ウインドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Left>  <C-w>h
nnoremap <C-Down>  <C-w>j
nnoremap <C-Up>    <C-w>k
nnoremap <C-Right> <C-w>l

" ウインドウの分割（横）
nnoremap    s- :split<CR>
" ウインドウの分割（縦）
nnoremap    s\ :vsplit<CR>
nnoremap    s\| :vsplit<CR>

" ウインドウの高さの統一
nnoremap    s= <C-w>=

" ウインドウのクローズ
nnoremap    sc <C-w>c
nnoremap    <Leader> c
nnoremap <silent> <leader>c <C-w>c

" /{pattern}の入力中は「/」をタイプすると自動で「\/」が、
" ?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" -----------------------------------------------------
" バッファ操作
" -----------------------------------------------------
" " 一つ次のバッファへ移動
" nnoremap <silent>bp :bp<CR>
" " 一つのバッファへ移動
" nnoremap <silent>bn :bn<CR>
" " バッファ移動
" nnoremap <silent>bb :b#<CR>:ls<CR>
" " バッファ一覧
" nnoremap <silent>bl :ls<CR>
" " 現在のバッファを閉じる
" nnoremap <silent>bd :bd%<CR>


" -----------------------------------------------------
" マウス操作
" -----------------------------------------------------
if has("mouse") " Enable the use of the mouse in all modes
  set mouse=a
endif


" タブ、あんまり使わなかった
""=======================
"" タブの取扱い
""=======================
"" Anywhere SID.
"function! s:SID_PREFIX()
"  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
"endfunction
"
"" Set tabline.  function! s:my_tabline()  "{{{
"  let s = ''
"  for i in range(1, tabpagenr('$'))
"    let bufnrs = tabpagebuflist(i)
"    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
"    let no = i  " display 0-origin tabpagenr.
"    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
"    let title = fnamemodify(bufname(bufnr), ':t')
"    let title = '[' . title . ']'
"    let s .= '%'.i.'T'
"    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
"    let s .= no . ':' . title
"    let s .= mod
"    let s .= '%#TabLineFill# '
"  endfor
"  let s .= '%#TabLineFill#%T%=%#TabLine#'
"  return s
"endfunction "}}}
"let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
"set showtabline=2 " 常にタブラインを表示
"
"" The prefix key.
"nnoremap    [Tag]   <Nop>
"nmap    t [Tag]
"" Tab jump
"for n in range(1, 9)
"  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
"endfor
"" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
"
"map <silent> [Tag]c :tablast <bar> tabnew<CR>
"" tc 新しいタブを一番右に作る
"map <silent> [Tag]x :tabclose<CR>
"" tx タブを閉じる
"map <silent> [Tag]n :tabnext<CR>
"" tn 次のタブ
"map <silent> [Tag]p :tabprevious<CR>
"" tp 前のタブ

" ターミナルモードを開く際、fishが使えるならシェルをfishにする
if executable("fish")
  set sh=fish
endif


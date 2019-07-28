" -----------------------------------------------------
" 操作設定
" -----------------------------------------------------
" set pasteすると貼り付けモードとなり、inoremapが効かなくなり、jjをESCと見なせなくなるため、コメントアウト
" set paste

" " インサートモードでbackspaceを有効に
" set backspace=indent,eol,start
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ノーマルモードでoで、新しい行を追加するが挿入モードへ入れず、ノーマルモードへ戻す
nmap o o<Esc>

" -----------------------------------------------------
" ブロック選択
" -----------------------------------------------------
" vを二回で行末まで選択
vnoremap v $h

" -----------------------------------------------------
" 検索
" -----------------------------------------------------
" スペース2度押しでカーソル下にある文字をハイライト（単語以外でも、一致する文字列をハイライト）
nnoremap <silent> <Space><Space> "zyiw:let @/ = @z<CR>:set hlsearch<CR>

" スペース3度押しでカーソル下にある単語をハイライト（\<や\>は、単語の境界を示す特殊文字）
nnoremap <silent> <Space><Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" ビジュアルモードの選択中にスペース２度押しで選択中の文字をハイライト
xnoremap <silent> <Space><Space> mz:call <SID>set_Vsearch()<CR>:set hlsearch<CR>`z

" ビジュアルモードの選択中に#で、選択中の文字列をハイライトしつつ置換モード(:%s/xxx/xxx/)に入る
xnoremap # mz:call <SID>set_Vsearch()<CR>:set hlsearch<CR>`z:%s/<C-r>///g<Left><Left>

" 選択した単語やカーソル下の単語を全体検索
" ノーマルモードでF3で、カーソル下にある文字（単語以外でも、一致する文字列を）をハイライトしつつ、Ripgrepで検索
nnoremap <F3> "zyiw:let @/ = @z<CR>mz:call <SID>set_search()<CR>:set hlsearch<CR>`z:Rg <C-r>/<CR>

" ビジュアルモードの選択中にF3で、選択中の文字列をハイライトしつつ、Ripgrepで検索
xnoremap <F3> mz:call <SID>set_search()<CR>:set hlsearch<CR>`z:Rg <C-r>/<CR>

" ノーマルモードでF4で、カーソル下にある文字（単語以外でも、一致する文字列を）をハイライトしつつ、現在のファイルをvimgrepで検索
nnoremap <F4> "zyiw:let @/ = @z<CR>mz:call <SID>set_search()<CR>:set hlsearch<CR>`z:vimgrep <C-r>/ %\|cw<CR>

xnoremap <F4> mz:call <SID>set_search()<CR>:set hlsearch<CR>`z:vimgrep <C-r>/ %\|cw<CR>

function! s:set_search()
  silent normal gv"zy
  let @/ = @z
endfunction
function! s:set_Vsearch()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
endfunction

" 面倒な\エスケープを簡易に。/{pattern}の入力中は「/」をタイプすると自動で「\/」が入力されるようになる。
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'

" 面倒な\エスケープを簡易に。?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'


" -----------------------------------------------------
" ウインドウ操作
" -----------------------------------------------------
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
nnoremap <space>- :<C-u>new<CR>
" ウインドウの分割（縦）
nnoremap <space>\  :<C-u>vnew<CR>
nnoremap <space>\| :<C-u>vnew<CR>
" ウインドウの高さの統一
nnoremap <space>= <C-w>=

" VISUALモードで連続ペーストできるようにする
" この設定をしたい理由：
"  'abc def 123' という文字列がある時、
"  'abc' をy(ヤンク)して'def' にp(ペースト)すると、
"  レジスタに'def'が入ってしまい、
"  '123'にも同じようにp(ペースト)したいのに、'def'
"  がペーストされてしまうため、
"  それを防ぎたいから（一言で言うと、何度も連続でpしたいから）。
"
" xnoremap = VISUALモードのmapを定義(再マップ無し)
" 左辺 <expr> p
"   = <expr> 右辺を指揮として評価する
" 右辺 'pgv"'.v:register.'y`>' 
"   = １(p) ペースト
"    + ２(gv) さっき選択していた範囲を
"    + ３([v:registerの結果]y) *レジスタを使用してヤンク
"    + ４(`>) で、最後に選択した範囲の終端にカーソルを戻す
"
xnoremap <expr> p 'pgv"'.v:register.'y`>'

" -----------------------------------------------------
" カーソル移動
" -----------------------------------------------------
" C-aで先頭、C-eで末尾(Emacs like cursor behavior)
"nnoremap <C-a> 0
inoremap <C-a> <Home>
cnoremap <C-a> <Home>
nnoremap <C-e> $
inoremap <C-e> <End>
cnoremap <C-e> <End>

" コード規約上120文字な言語があったりするので、その目安に線を引く
let &colorcolumn=join(range(121,121),",")
hi ColorColumn ctermbg=235 guibg=#2c2d27

" -----------------------------------------------------
" 保存、終了系
" -----------------------------------------------------
" 終了
nnoremap Q :<C-u>:q<CR>
nnoremap W :<C-u>:w<CR>:echo "SAVED! [" . expand("%:p") . "]"<CR>


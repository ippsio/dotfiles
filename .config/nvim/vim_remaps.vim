" -----------------------------------------------------
" 操作設定
" -----------------------------------------------------
" set pasteすると貼り付けモードとなり、inoremapが効かなくなり、jjをESCと見なせなくなるため、コメントアウト
" set paste

" " インサートモードでbackspaceを有効に
" set backspace=indent,eol,start
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" -----------------------------------------------------
" ブロック選択
" -----------------------------------------------------
" vを二回で行末まで選択
vnoremap v $h

" -----------------------------------------------------
" 検索
" -----------------------------------------------------
" スペース２度押しでカーソル下にある単語をハイライト
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

" ビジュアルモードの選択中にスペース２度押しで選択中の文字をハイライト
xnoremap <silent> <Space><Space> mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z
xnoremap * :<C-u>call <SID>set_vsearch()<CR>/<C-r>/<CR>

" ビジュアルモードの選択中に#で選択中の文字列をハイライトしつつ置換モード(:%s/xxx/xxx/)に入る
xnoremap # mz:call <SID>set_vsearch()<CR>:set hlsearch<CR>`z:%s/<C-r>///g<Left><Left>
function! s:set_vsearch()
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

" 何か挙動が安定しない。特にレジスタとクリップボード間でうまいこといかない。のでコメントアウト
"
" " -----------------------------------------------------
" " レジスタ
" " -----------------------------------------------------
" " レジスタ系(基本、ゼロレジスタをコピペに使うようにする。使い勝手は使いながら改善)
" " ペーストする時は0レジスタに入ってる物をペーストする
" nnoremap p "0p
" vnoremap p "0p
"
" " クリップボードの情報はCtrl+Shift+Pでペーストする
" nnoremap <C-P> "*p
" vnoremap <C-P> "*p
"
" " ブロック選択時にxとかdでカットやヤンクした時は、その内容の入れ先は0レジスタに設定。
" vnoremap x "0x
" vnoremap d "0d
" vnoremap y "0y
"
" " 行カットや行ヤンクした時は、その行の内容の入れ先を0レジスタに設定。
" nnoremap dd "0dd
" nnoremap yy "0yy

" VISUALモードで連続ペーストできるようにする
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
" 保存、終了系
" -----------------------------------------------------
" 終了
nnoremap Q :<C-u>:q<CR>
nnoremap W :<C-u>:w<CR>:echo "SAVED! [" . expand("%:p") . "]"<CR>


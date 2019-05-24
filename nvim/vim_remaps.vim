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
" ビジュアルモードの選択範囲を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" スペース２度押しでカーソル下にある単語をハイライト
nnoremap <silent> <Space><Space> "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>

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
nnoremap <space>s- :<C-u>split<CR>
" ウインドウの分割（縦）
nnoremap <space>s\  :<C-u>vsplit<CR>
nnoremap <space>s\| :<C-u>vsplit<CR>

" ウインドウの高さの統一
nnoremap <space>s= <C-w>=

" -----------------------------------------------------
" レジスタ
" -----------------------------------------------------
" レジスタ系(基本、ゼロレジスタをコピペに使うようにする。使い勝手は使いながら改善)
" ペーストする時は0レジスタに入ってる物をペーストする
nnoremap p "0p
vnoremap p "0p

" クリップボードの情報はCtrl+Shift+Pでペーストする
nnoremap <C-P> "*p
vnoremap <C-P> "*p

" ブロック選択時にxとかdでカットやヤンクした時は、その内容の入れ先は0レジスタに設定。
vnoremap x "0x
vnoremap d "0d
vnoremap y "0y

" 行カットや行ヤンクした時は、その行の内容の入れ先を0レジスタに設定。
nnoremap dd "0dd
nnoremap yy "0yy


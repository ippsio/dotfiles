" -----------------------------------------------------
" 操作設定
" -----------------------------------------------------
" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" やっぱコメントアウト。
" " ;は;とする。USキーボードで:を打つにはSHIFTキーも同時に押す必要があり面倒くさいので
" nnoremap ; :
"
" " コマンドモードで;や:で、コマンドモードを抜ける。Esc押すのが面倒臭いので
" cnoremap <expr> : getcmdline() != '' ? ':' : 'echo ""<CR><Esc>'
" cnoremap <expr> ; getcmdline() != '' ? ';' : 'echo ""<CR><Esc>'

" 自分にとってはqで:recording開始のトリガーになるのは邪魔なので無効化。
nnoremap q <Nop>
xnoremap q <Nop>
" 同じく、@でrecordingした内容を再生することも邪魔なので無効化
nnoremap @ <Nop>
xnoremap @ <Nop>

" -----------------------------------------------------
" ブロック選択
" -----------------------------------------------------
" vを二回で行末まで選択
"vnoremap v $h

" -----------------------------------------------------
" 検索
" -----------------------------------------------------
" space2度押しで文字をハイライト
nnoremap <silent> <Space><Space> mz:call <SID>hi_word()<CR>
xnoremap <silent> <Space><Space> mz:call <SID>hi_selected()<CR>

" F3で、カレントバッファをハイライト＋Ripgrep検索(要ripgrepコマンド)
nnoremap <F3>       mz:call <SID>hi_word_and_grep(1)<CR>
xnoremap <F3>       mz:call <SID>hi_selected_and_grep(1)<CR>
cnoremap <F3> <CR>gnmz:call <SID>hi_selected_and_grep(1)<CR>

" カーソル下にある単語をハイライト
function s:hi_word()
  " （\<や\>は、単語の境界を示す特殊文字）
  silent normal "zyiw
  let @/ = '\<' . @z . '\>'
  call feedkeys(":set hlsearch\<CR>", "n")
  silent normal `z
endfunction

" カーソル下にある単語をgrep(可能ならripgrep)
" range_cd: 0=カレントバッファ内を検索、1=全体を検索..という意味として定義
function s:hi_word_and_grep(range_cd)
  call s:hi_word()
  silent normal gn"zy
  if a:range_cd == 0
    call s:vimgrep_current_buf_z_register()
  else
    call s:grep_z_register()
  endif
endfunction

" ビジュアルモードで選択中の文字をハイライト
function s:hi_selected()
  silent normal gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
  call feedkeys(":set hlsearch\<CR>", "n")
  silent normal `z
endfunction

" ビジュアルモード選択中の文字をgrep(可能ならripgrep)
function s:hi_selected_and_grep(range_cd)
  call s:hi_selected()
  silent normal gv"zy
  if a:range_cd == 0
    call s:vimgrep_current_buf_z_register()
  else
    call s:grep_z_register()
  endif
endfunction

" Zレジスタの内容をgrep(可能ならripgrep)
function s:grep_z_register()
  let @z = escape(@z, '\()[]{}|^&#$%*+?')
  let @z = substitute(@z, '\\', '\\\\', 'g')
  let @z = substitute(@z, '"', '\\"', 'g')
  let @z = substitute(@z, '`', '\\`', 'g')
  if executable('rg')
    call feedkeys(":Rg \<C-r>z\<CR>", "n")
  else
    "call feedkeys(":grep \"\<C-r>z\"\<CR>", "n")
    call feedkeys(":grep \"\<C-r>z\"", "n")
  endif
endfunction

" Zレジスタの内容で、カレントバッファ内をvimgrep
function s:vimgrep_current_buf_z_register()
  let @z = escape(@z, '\()[]{}|^&#$%*+?')
  let @z = substitute(@z, '\\', '\\\\', 'g')
  let @z = substitute(@z, '"', '\\"', 'g')
  let @z = substitute(@z, '`', '\\`', 'g')
  " call feedkeys(":vimgrep \"\<C-r>z\" %\<CR>", "n")
  call feedkeys(":vimgrep \"\<C-r>z\" %", "n")
endfunction

" /で検索モードに入った際、/{pattern}の入力中は「/」や「?」をタイプすると自動で\エスケープする。
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
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
" ノーマルモード中にQ、または素早くqqと入力した場合は:q<CR>とみなす
nnoremap qq :q<CR>
nnoremap Q :<C-u>:q<CR>
nnoremap <silent> W :<C-u>:w<CR>:echo 'SAVED! ' . strftime("%Y/%m/%d %H:%M:%S") . '[' . substitute(expand("%:p"), $HOME, "~", "g") . ']'<CR>


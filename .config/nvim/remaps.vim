" -----------------------------------------------------
" 操作設定
" -----------------------------------------------------

" [Recording]
" 自分にとってはqで:recording開始のトリガーになるのは邪魔なので無効化。
" 同じく、@でrecordingした内容を再生することも邪魔なので無効化
nnoremap q <Nop>
xnoremap q <Nop>
vnoremap q <Esc>
nnoremap @ <Nop>
xnoremap @ <Nop>

" [ヘルプ]
" F1でヘルプが開くと鬱陶しいので無効化。
nnoremap <F1> <Nop>
inoremap <F1> <Nop>

nnoremap <F3> gf

nnoremap <F5> :e<CR>
nnoremap <F6> :<C-u>:qa<CR>
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "	"

" Shiftを押しならがTabを押せば、直接Tab文字が入力されるようにする(Tab文字単体で押しても、4文字位のスペースが入力されるだけなので時々不便なのである)。
inoremap <S-Tab> <C-v><Tab>

" [ブロック選択]
" vを二回で行末まで選択
vnoremap v $h

" [折りたたみ]
nnoremap <expr> i foldlevel('.') > 0 && foldclosed('.') != -1 ? 'za' : 'i'
nnoremap <expr> o foldlevel('.') > 0 && foldclosed('.') != -1 ? 'zo' : 'o'
vnoremap <expr> o foldlevel('.') > 0 && foldclosed('.') != -1 ? 'zo' : 'o'
nnoremap <expr> - foldlevel('.') > 0 ? 'za' : '-'

" [ハイライト]
" space2度押しでカーソル下の文字をハイライト。
nnoremap <silent> <Space><Space> mz:call <SID>hi_word()<CR>
function s:hi_word()
  " （\<や\>は、単語の境界を示す特殊文字）
  normal "zyiw

  let @/ = '\<' . @z . '\>'
  "let @/ = @z
  call feedkeys(":set hlsearch\<CR>", "n")
  normal `z
endfunction
" space2度押しで選択中の文字をハイライト。
xnoremap <silent> <Space><Space> mz:call <SID>hi_selected()<CR>
function s:hi_selected()
  silent normal! gv"zy
  let @/ = '\V' . substitute(escape(@z, '/\'), '\n', '\\n', 'g')
  call feedkeys(":silent set hlsearch\<CR>", "n")
  silent normal `z
endfunction
" ESCでハイライト解除
nmap <silent> <Esc> :<C-u>nohlsearch<CR>

" [検索]
" <F4> でハイライト中の文字(zレジスタの文字)をGrep。
nnoremap <F4>       mz:call <SID>grep_z_register()<CR>
function s:grep_z_register()
  " NOTE: どうやら2回escapeすると期待動作する。1回escapeだと期待動作しない。理由は知らん。
  let l:search_word = escape(@z, '\"$`')
  let l:search_word = escape(l:search_word, '\"$`')
  call feedkeys(":Grep " . l:search_word . "\<CR>", "n")
endfunction

" [コマンドモードでの入力値の置換]
" /で検索モードに入った際、/{pattern}の入力中は「/」や「?」をタイプすると自動で\エスケープする。
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" [ウインドウ操作]
" C-h, C-j, C-k, C-l でウインドウ間の移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" <space>-や<space>\ でウインドウの分割
nnoremap <space>- :<C-u>new<CR>
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
xnoremap <expr> p 'pgv"'.v:register.'y`>'
"xnoremap p "_xP`<

" [カーソル移動]
" C-aで先頭、C-eで末尾(Emacs like cursor behavior)
inoremap <C-a> <Home>
inoremap <C-e> <End>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
"nnoremap <C-a> 0 ノーマルモードでのC-aは、数値のインクリメントという既存機能がある。この機能は活かしたいのでnnoremap <C-a>は何も設定しない。
nnoremap <C-e> $

" カーソルの上下を、<C-p>、<C-n>にする。
" コマンドモードのwildmenu表示中に、選択肢をカーソルキーで上下移動したい時がある。
" この設定をしないと、wildmenu内で上下カーソルを押した時、wildmenuの選択状態が解除されてしまう。
" wildmenu上での正しい上下移動は<C-p>、<C-n>。
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" [保存、終了系]
" ノーマルモード中にQは:q<CR>とみなす
nnoremap qq    :<C-u>:q<CR>
" ノーマルモード中に素早くqqと入力した場合は:q<CR>とみなす
nnoremap Q :<C-u>q<CR>
nnoremap W :call <SID>SaveFile()<CR>

function! s:SaveFile()
  try
    silent :w
    let l:msg = 'SAVED! ' . strftime("%Y/%m/%d %H:%M:%S") . '[' . substitute(expand("%:p"), $HOME, "~", "g") . ']'
    let l:maxlen = v:echospace + ((&cmdheight - 1) * &columns)
    echom strpart(l:msg, 0, l:maxlen)
  catch
    echo "保存に失敗しました: " . v:errmsg
  endtry
endfunction

" [その他]
" ファイル名と行番号を表示する。ついでにファイル名をクリップボードにコピーする。
" nnoremap <silent> <C-g> :let @* = substitute(expand("%:p"), $HOME, "~", "g")<CR><C-g>
nnoremap <silent> <C-g> :call <SID>CopyFilename()<CR>

function! s:CopyFilename()
  let l:dot_git = system('cd ' . expand('%:h') . '; git rev-parse --git-dir 2>/dev/null')
  if l:dot_git == ''
    " Outside git repository.
    let l:file = substitute(expand("%:p"), $HOME, "~", "g")
  else
    " Inside git repository.
    let git_dir = fnamemodify(l:dot_git, ':h')
    let l:file = system('cd ' . git_dir . '; git ls-files --full-name ' . expand('%') . ' 2>/dev/null')
    if l:file == ''
      let l:file = substitute(expand("%:p"), $HOME, "~", "g")
    endif
  endif
  let l:path = substitute(l:file, "[\\n|\\r]", "", "g")
  let @* = l:path
  let l:msg = "Filename copied '" . l:path . "'"
  let l:maxlen = v:echospace + ((&cmdheight - 1) * &columns)
  echom strpart(l:msg, 0, l:maxlen)
endfunction

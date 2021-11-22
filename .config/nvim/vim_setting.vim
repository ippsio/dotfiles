
" --------------------
"  mapの動作
" --------------------
"Time in milliseconds to wait for a mapped sequence to complete.
" map（nnoremap, xnoremap等）が発火するまでの待ち時間（ミリ秒）
"
" 例えばこの値を200と設定したとして、
" <Space><Space>.........(a) と
" <Space><Space><Space>..(b) というmapがあった時、
" (a)が発火するのはスペースを2回連打から200ms後となる。
"
" (b)を発火させるには、(a)が発火する前にもう一度スペースキーを入力する必要がある。
" 急がないと(a)が発火しちゃう。
"set timeoutlen=400

" --------------------
"  Tab/ スペース/改行
" --------------------
" 挿入モードでTABキーを押した際、対応する数のスペースを入力
set expandtab

" 画面上でタブ文字が占める幅の指定
set tabstop=2

" 自動インデントでずれる幅の指定
set shiftwidth=2

" 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅の指定
set softtabstop=2

" 改行時に前の行のインデントを継続する
set autoindent

" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent

" yamlファイル等、#（シャープ）が深すぎるオートインデントをしてしまう事があるため、#はオートインデントしないようにする。
set indentkeys-=0#

" インデントをshiftwidthの倍数に丸める
set shiftround

" -------------------
"  ファイル/バッファ
" -------------------
" エンコード, ファイルエンコード
set encoding=utf-8
set fileencoding=utf-8

" .swapファイルを作らない
set noswapfile

" バックアップファイルを作らない
set nowritebackup

" バックアップをしない
set nobackup

" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden

" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" --------------
"  移動
" --------------
" スクロールする時に下が見えるようにする
"set scrolloff=10

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" --------------
"  ウインドウ
" --------------
" ウインドウを横分割する時、右に分割する
set splitright
" ウインドウを縦分割する時、下に分割する
set splitbelow

" --------------
"  コマンドウインドウ
" --------------
"
""" " コマンドウインドウをちょっと広めにとっておく（情報を表示するのに、何かと良いような気がしたので）
""" set cmdheight=2 " 2行にしてみた

" --------------
"  その他
" --------------
" ビープ音を消す
set belloff=all

" OSのクリップボードを使う
set clipboard=unnamed

" compatibleオプションをオフにする
set nocompatible

" 起動時のメッセージを非表示にする（ウガンダ非表示化）
set shortmess+=I

" --------------
"  括弧
" --------------
" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>

" 対応括弧をハイライト表示する
"set showmatch

" 対応括弧の表示秒数を1秒にする
set matchtime=1

" --------------
"  折りたたみ
" --------------
" 折りたたみが個人的に好きでないので、無効化する
" 例えば :Gdiff 等で勝手に折りたたまれた状態で表示されると、いらいらする
set nofoldenable

" --------------
"  表示
" --------------
" 行番号を表示
set number

" 行番号横のsigncolumnを常時表示
" これをyesにしておくと、git-gutter.vimなどで変更が検知された時に、行番号あたりの所がガタガタせず、目が疲れない。
set signcolumn=yes

set cursorline
" 'gui'となっているが256色環境(xterm-256colorな環境)でも機能する。
" hihlight はgui,guibg,guifgなどは24bitカラーな環境の設定を表すような気がするが、
" guicursorはxterm-256colorな環境にも機能してくれる)。
"
" デフォルトでは n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
set guicursor=

" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap
" ウィンドウの幅より長い行は折り返され、次の行に続けて表示されない
"set nowrap

" 入力されているテキストの最大幅を無効にする
set textwidth=0

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" ◆や○文字が崩れる問題を解決"
set ambiwidth=double
"set ambiwidth=single

" ①②③
" ⇒←■

" シンタックスハイライトの最大行数
"set synmaxcol=2048
set synmaxcol=1024

" パターンマッチングに使うメモリ量の最大値(キロバイト単位。デフォルトでは1000)
set maxmempattern=100000 " 100,000KB = 100MB

" 256色対応
set t_Co=256

" コマンドを画面最下部に表示する
set showcmd

" --------------
"  補完
" --------------
" 補完の際の大文字小文字の区別しない
set infercase

" --------------
"  検索
" --------------
" 小文字の検索でも大文字も見つかるようにする
set ignorecase

" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase

" インクリメンタルサーチを行う
set incsearch

" 検索結果をハイライト表示
set hlsearch

" インタラクティブな置換。vim-overのようなもの。
" ⇒重いからoffにします。
"set inccommand=nosplit
"set inccommand=split
"set inccommand=

" --------------
" マウス操作
" --------------
if has("mouse")
"" マウス使うのを辞めるのはやめた。やっぱりマウスホイールでスクロールしてくれるのは楽
""   " マウスクリックで微妙にスクロールしたりして使いにくいので、マウス機能は-=aで明示的にオフする
"   set mouse-=a
  set mouse=n
endif


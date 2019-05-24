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
set scrolloff=5

" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline

" --------------
"  その他
" --------------
" ビープ音を消す
set belloff=all

" OSのクリップボードを使う
set clipboard=unnamed

" compatibleオプションをオフにする
set nocompatible

" --------------
"  括弧
" --------------
" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>

" 対応括弧をハイライト表示する
set showmatch

" 対応括弧の表示秒数を3秒にする
set matchtime=3

" --------------
"  表示
" --------------
" 行番号を表示
set number

" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap

" 入力されているテキストの最大幅を無効にする
set textwidth=0

" 不可視文字を表示
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%

" ◆や○文字が崩れる問題を解決"
"set ambiwidth=double

" シンタックスハイライトの最大行数
set synmaxcol=2048

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

" --------------
" マウス操作
" --------------
if has("mouse")
  set mouse=a
endif

" ------------
" ターミナル
" ------------
" ターミナルモードを開く際、fishが使えるならシェルをfishにする
" NERDTree-git-pluginが、fishからsystem functionを呼べない場合があるため、コメントアウト
" NOTE: https://github.com/Xuyuanp/nerdtree-git-plugin
"if executable("fish")
"  set sh=fish
"endif
set sh=/bin/bash

" 全角スペースのハイライト
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif


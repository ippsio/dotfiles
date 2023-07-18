" shadaを無効化します。
" shada は通常~/.local/state/nvim/shada/main.shada に保存されていると思います。
" shada には最近のジャンプリスト(:jumps)や実行したコマンドの履歴、マーク(:marks)の情報が自動保存されます。
"
" If you exit Vim and later start it again, you would normally lose a lot of
" information.  The ShaDa file can be used to remember that information, which
" enables you to continue where you left off.  Its name is the abbreviation of
" SHAred DAta because it is used for sharing data between Neovim sessions.
set shada=

" nocompatible compatibleオプションをオフにする
set nocompatible

" [タブ]
" expandtab 挿入モードでTABキーを押した際、対応する数のスペースを入力
" tabstop 画面上でタブ文字が占める幅の指定
" softtabstop 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅の指定
set expandtab
set tabstop=2
set softtabstop=2

" [インデント]
" shiftwidth 自動インデントでずれる幅の指定
" shiftround インデントをshiftwidthの倍数に丸める
" autoindent 改行時に前の行のインデントを継続する
" smartindent 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
" indentkeys #入力に対してはオートインデントしないようにする。yamlファイル等、#（シャープ）が深すぎるオートインデントをしてしまう事があるため。
set shiftwidth=2
set shiftround
set autoindent
set smartindent
set indentkeys-=0#

" [エンコーディング]
" encoding Vim内部で使われる文字エンコーディング
" fileencoding カレントバッファのファイルの文字エンコーディング
set encoding=utf-8
set fileencoding=utf-8

" [スワップ、バックアップ]
" noswapfile .swapファイルを作らない
" nowritebackup バックアップファイルを作らない
" nobackup バックアップをしない
set noswapfile
set nowritebackup
set nobackup

" [バッファ]
" hidden 変更中のファイルでも、保存しないで他のファイルを表示
" switchbuf 新しく開く代わりにすでに開いてあるバッファを開く
set hidden
set switchbuf=useopen

" [スクロール]
" scrolloff カーソルの上または下には、最低でもこのオプションに指定した数の行が表示 される。
" nostartofline 移動コマンドを使ったとき、行頭に移動しない
set scrolloff=20
set nostartofline

" [ウインドウ分割]
" splitright ウインドウを横分割する時、右に分割する
" splitbelow ウインドウを縦分割する時、下に分割する
set splitright
set splitbelow

" [その他]
" belloffビープ音を消す
" OSのクリップボードを使う
" shortmess 起動時のメッセージを非表示にする（ウガンダ非表示化）
set belloff=all
set clipboard=unnamed
set shortmess+=I

" [括弧]
" showmatch 対応括弧をハイライト表示する。 # NOTE: see 'itchyny/vim-parenmatch'
" matchpairs& matchpairs 対応括弧に<と>のペアを追加。# NOTE: see 'itchyny/vim-parenmatch'
" matchtime 対応括弧の表示秒数。 # NOTE: see 'itchyny/vim-parenmatch'
"set showmatch
"set matchtime=1
"set matchpairs& matchpairs+=<:>

" [折りたたみ]
" nofoldenable 折りたたみが個人的に好きでないので、無効化する。例えば :Gdiff 等で勝手に折りたたまれた状態で表示されると、いらいらする。
set nofoldenable

" [表示]
" number 行番号を表示。
" signcolumn 行番号横のsigncolumnを常時表示。これをyesにしておくと、git-gutter.vimなどで変更が検知された時に、行番号あたりの所がガタガタせず、目が疲れない。
" cursorline カーソルがあるテキスト行を CursorLine |hl-CursorLine| で強調する。
" guicursor Vimのそれぞれのモード内でのカーソルの外観を指定する。デフォルトでは n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20。
" wrap ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
" textwidth 入力されているテキストの最大幅を無効にする
" list, listchars 不可視文字を表示
" ambiwidth EastAsian文字が崩れる問題を解決したい（ひしがた等の文字を2バイト(double)として扱って欲しいという願いを込める。残念ながらちゃんと機能するとは言い切れない）
" NOTE: ambiwidth関連の情報：vim には setcellwidths が実装されたらしいので、それを使えそう。neovim には setcellwidths がまだ実装されていないので、使えない。
" synmaxcol シンタックスハイライトの最大行数
" t_Co 256色対応
set number
set signcolumn=yes
set cursorline
"set cursorlineopt="line,screenline,number"
set cursorlineopt=screenline,number

set guicursor=
set wrap
set textwidth=0
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set ambiwidth=double
set synmaxcol=1024
set t_Co=256

" [表示: コマンド]
" showcmd コマンドを画面最下部に表示する
set showcmd

set showtabline=2

" [検索/置換]
" maxmempattern パターンマッチングに使うメモリ量の最大値(1は1kB。デフォルトでは1000)
" ignorecase 小文字の検索でも大文字も見つかるようにする
" smartcase ただし大文字も含めた検索の場合はその通りに検索する
" incsearch インクリメンタルサーチを行う
" hlsearch 検索結果をハイライト表示
" inccommand インタラクティブな置換。vim-overのようなもの。重いからoffにします。
set maxmempattern=100000 " 100,000KB = 100MB
set ignorecase
set smartcase
set incsearch
set hlsearch
set inccommand=

" [補完]
" infercase 補完の際の大文字小文字の区別しない
set infercase

" [マウス]
" mouse マウス利用可能なモードを設定する。
if has("mouse")
  set mouse=a
endif


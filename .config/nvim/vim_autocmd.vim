" vimgrepしたら結果をQuickFixに表示
"
" - vimgrep
"  :vim 検索したい文字列 検索したいファイル
"    または
"  :vim 検索したい文字列 検索したいディレクトリ/*
"au QuickFixCmdPost *grep* cwindow
au QuickfixCmdPost make,grep cw

" set 'updatetime' to 1 seconds when in insert mode
"au InsertEnter * let updaterestore = &updatetime | set updatetime=3
"au InsertLeave * let &updatetime = updaterestore

" automatically leave insert mode after 'updatetime' milliseconds of inaction
"set updatetime=2000
"au CursorHoldI * echo "aaa"


" vimgrepしたら結果をQuickFixに表示
"
" - vimgrep
"  :vim 検索したい文字列 検索したいファイル
"    または
"  :vim 検索したい文字列 検索したいディレクトリ/*
autocmd QuickFixCmdPost *grep* cwindow
autocmd QuickfixCmdPost make,grep cw

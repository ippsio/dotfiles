augroup QfAutoCommands
  autocmd!
  " vim上でのgrep, vimgrep, rg(ripgrep)の結果を、即quickfixウインドウに表示する
  au QuickFixCmdPost *grep* cwindow

  " Quickfixのバッファから抜ける時は、Quickfixを自動的に閉じる。
  au BufLeave * if &filetype == 'qf' | ccl | endif
augroup END

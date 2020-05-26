augroup QfAutoCommands
  autocmd!
  " vim上でのgrep, vimgrep, rg(ripgrep)の結果を、即quickfixウインドウに表示する
  au QuickFixCmdPost *grep* cwindow

  " Quickfixのバッファから抜ける時は、Quickfixを自動的に閉じる。
  au BufLeave * if &filetype == 'qf' | ccl | endif
augroup END

augroup FileTypeRuby
  autocmd!
  " @hoge のような変数に対し、先頭の@も単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=@-@

  " save! のような末尾の!も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=?

  " validate? のような末尾の?も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=!

  " hoge.map(&:fuga) の中身の &:fuga を、単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=:
  au FileType ruby setlocal iskeyword+=&

augroup END

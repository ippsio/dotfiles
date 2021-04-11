augroup QfAutoCommands
  autocmd!
  " vim上でのgrep, vimgrep, rg(ripgrep)の結果を、即quickfixウインドウに表示する
  au QuickFixCmdPost *grep* cwindow

  """ " Quickfixのバッファから抜ける時は、Quickfixを自動的に閉じる。
  """ au BufLeave * if &filetype == 'qf' | ccl | endif
augroup END

" augroup AuEventVisualize
"   autocmd!
"   autocmd FocusGained * :echo 'FocusGained'
"   autocmd FocusLost * :echo 'FocusLost'
"   autocmd WinEnter * :echo 'WinEnter'
"   autocmd BufNew * :echo 'BufNew'
"   autocmd BufRead * :echo 'BufNew'
"   autocmd BufEnter * :echo 'BufEnter'
"   autocmd BufLeave * :echo 'BufLeave'
"   autocmd BufWinEnter * :echo 'BufWinEnter'
"   autocmd BufWinLeave * :echo 'BufWinLeave'
" augroup END

augroup FileTypeRuby
  autocmd!
  " @hoge のような変数に対し、先頭の@も単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=@-@

  " save! のような末尾の!も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=?

  " validate? のような末尾の?も、区切り文字ではなく単語として扱ってもらう。
  au FileType ruby setlocal iskeyword+=!

  " これは無いほうが使いやすかったのでコメントアウト
  " " hoge.map(&:fuga) の中身の &:fuga を、単語として扱ってもらう。
  " " au FileType ruby setlocal iskeyword+=:
  " " au FileType ruby setlocal iskeyword+=&
augroup END

if has('mac')
  augroup MyIMEGroup
    autocmd!
    " IMEをOFFにする(102=英数key)（インサートモード抜け時とフォーカス取得／開放時）
    au InsertLeave,FocusGained,FocusLost * :call system('osascript -e "tell application \"System Events\" to key code 102"')
endif

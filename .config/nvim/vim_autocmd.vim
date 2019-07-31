"<Left> vimgrepしたら結果をQuickFixに表示
"
" - vimgrep
"  :vim 検索したい文字列 検索したいファイル
"    または
"  :vim 検索したい文字列 検索したいディレクトリ/*
"au QuickFixCmdPost *grep* cwindow
au QuickfixCmdPost make,grep cw

let s:smile_time = 2000
" スマイルコマンドを実行する関数
function! ShowSmile(timer)
  call feedkeys("\<Esc>")
endfunction

" 文字が入力された場合にタイマーをリセットする関数
function! UpdateSmileTimer(timer)
  call timer_stop(a:timer)
  let s:smile_timer = timer_start(s:smile_time, 'ShowSmile')
endfunction

augroup smile
  autocmd!
  " 挿入モードに入って s:smile_time が経過したら ShowSmile() を実行
  " 入力があったら UpdateSmileTimer() を実行
  au InsertEnter * let s:smile_timer = timer_start(s:smile_time, 'ShowSmile')
  au InsertCharPre * call UpdateSmileTimer(s:smile_timer)
augroup END


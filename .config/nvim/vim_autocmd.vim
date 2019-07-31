"
" - vimgrep
"  :vim 検索したい文字列 検索したいファイル
"    または
"  :vim 検索したい文字列 検索したいディレクトリ/*
au QuickFixCmdPost *grep* cwindow

" {ここから}
" 日本語入力中にインサートモードを抜けてしまうので、コメントアウト。英語圏の人はこれで良いかと思いますが。
" " インサートモードに入ってから一定時間入力が無ければインサートモードを抜ける
" let s:exp_time = 2000
" " Leave Insert mode
" function! LeaveIns(timer)
"   call feedkeys("\<Esc>")
" endfunction
"
" function! ResetTimer(timer)
"   call timer_stop(a:timer)
"   let s:exp_timer = timer_start(s:exp_time, 'LeaveIns')
" endfunction
"
" augroup leave_insert_mode
"   autocmd!
"   " 挿入モードに入って s:exp_time が経過したら LeaveIns() を実行
"   " 入力があったら ResetTimer() を実行
"   au InsertEnter * let s:exp_timer = timer_start(s:exp_time, 'LeaveIns')
"   au InsertCharPre * call ResetTimer(s:exp_timer)
"   au CursorMovedI * call ResetTimer(s:exp_timer)
" augroup END
" {ここまで}

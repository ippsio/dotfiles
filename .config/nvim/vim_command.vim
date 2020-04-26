" 挙動が気に入らないのでコメントアウト。
" プレビューできるのは有り難いが、カーソルがペインを外れると、すごく微妙な動きになる、というか機能しなくなる。
" 残骸を手で消さないとダメな感じになり、使いにくい。
" Quickfixを使った結果の方が見やすい気がするので、コメントアウトします。
"
""" " ripgrep+fzf
""" command! -bang -nargs=* Rg
"""   \ call fzf#vim#grep(
"""   \ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
"""   \ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
"""   \ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
"""   \ <bang>0)


function! SqlformatSelection() range
  " 選択範囲をレジスタに保存
  silent execute a:firstline . ',' . a:lastline . 'y'
  " 選択範囲を取得
  let l:selection = getreg('"')
  " system() でパイプ処理
  let l:result = system('echo ' . shellescape(l:selection) . ' | sqlformat -r -k upper -')
  " 結果で選択範囲を置換
  call setline(a:firstline, split(l:result, '\n'))
endfunction
command! -range Sqlformat <line1>,<line2>call SqlformatSelection()
" select * from apples inner join oranges on apples.id = oranges.apple_id

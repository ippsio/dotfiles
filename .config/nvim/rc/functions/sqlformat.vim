function! EchoSelection() range
  " 選択範囲をレジスタに保存
  silent execute a:firstline . "," . a:lastline . "y"
  " echo で表示
  let l:selection = getreg('"')
  execute "!echo " . shellescape(l:selection) . "| sqlformat -r -k upper -"
endfunction

command! -range EchoSel <line1>,<line2>call EchoSelection()

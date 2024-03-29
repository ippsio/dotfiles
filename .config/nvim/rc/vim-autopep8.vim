"autopep8を<f8>で実行
function! Preserve(command)
  " Save the last search.
  let search = @/
  " Save the current cursor position.
  let cursor_position = getpos('.')
  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)
  " Execute the command.
  execute a:command
  " Restore the last search.
  let @/ = search
  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt
  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction
function! Autopep8()
  call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction
autocmd FileType python nnoremap <f8> :call Autopep8()<CR>


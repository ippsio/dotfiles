nnoremap <silent> <Space>m :<C-u>call EditDailyMemo()<CR>
function! EditDailyMemo()
  let l:daily_memo_dir = $HOME . '/notes/memo'
  let l:memo_dir = l:daily_memo_dir.'/'.strftime('%Y_%m')
  let l:memo_file = l:memo_dir.'/'.strftime('%Y_%m%d').'.md'
  call mkdir(l:memo_dir, 'p')
  execute "tabnew ".l:memo_file
endfunction


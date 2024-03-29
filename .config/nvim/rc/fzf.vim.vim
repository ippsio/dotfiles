let g:fzf_layout = {'window': { 'width': 0.95, 'height': 0.95 } }
" " Default fzf layout
" " - Popup window (center of the screen)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" " - Popup window (center of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }
" " - Popup window (anchored to the bottom of the current window)
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true, 'yoffset': 1.0 } }
" " - down / up / left / right
" let g:fzf_layout = { 'down': '40%' }
" " - Window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10new' }

" ジャンプリストをfzfで絞り込む
nnoremap <BS> :Jumps<CR>

" バッファ一覧をfzfで絞り込む
nnoremap ; :Buffers<CR>

" 現在開いてるファイルがgit管理下ならそのディレクトリを、そうでなければ現在のパスを返す。
function! s:GetDir(args0)
  if a:args0 != ''
    if isdirectory(a:args0)
      return a:args0
    else
      throw 'ディレクトリ ['.a:args0.'] っつうのが見つからない。'
    endif
  else
    " NOTE: 通常、git管理されたフォルダのサブフォルダで `git rev-parse --show-toplevel` とすると、gitのルートディレクトリが取得できると思うのですが、
    " git difftoolコマンドから起動されたnvimの場合(?)
    " system('cd ' . expand('%:h') . '; git rev-parse --show-toplevel 2>/dev/null' の結果として expand('%:h') 相当の値しか得られないという現象が発生しました。
    " そうした状況においても
    " system('cd ' . expand('%:h') . '; git rev-parse --git-dir 2>/dev/null'       の結果は、正しいgitルートディレクトリの.gitフォルダの絶対パスが得られました。
    " そのためここでは `git rev-parse --git-dir` に頼ることにしました。
    let s:dot_git = system('cd ' . expand('%:h') . '; git rev-parse --git-dir 2>/dev/null')
    if s:dot_git == ''
      return expand('%:p:h')
    else
      let s:git_root = fnamemodify(s:dot_git, ':h')
      return s:git_root
    endif
  endif
endfunction

"nnoremap <silent> ' :<C-u>:BLinesWithPreview  def <CR>
"nnoremap <silent> ? :<C-u>:BLinesWithPreview<CR>
" NOTE: ここでのシングルクォートによるremapは、
" ハイライト一覧の閲覧「:so $VIMRUNTIME/syntax/hitest.vim」実行時にバッティングします。
" ハイライト一覧を見たい場合、このnnoremap は一旦コメントアウトしましょう...。
nnoremap <silent> ' :<C-u>:BLinesWithPreview<CR>
nnoremap <silent> L :<C-u>:BLinesWithPreview<CR>
command! -bang -nargs=* BLinesWithPreview
      \ call fzf#vim#grep(
      \   'rg '
      \     . '--color=never '
      \     . '--with-filename '
      \     . '--line-number '
      \     . '--no-heading '
      \     . '--smart-case . '.fnameescape(expand('%:p')),
      \   0,
      \   fzf#vim#with_preview(
      \     {
      \       'options': '--prompt="' . expand('%:p:h') . ' > " '
      \         . '--info=inline '
      \         . '--layout reverse '
      \         . '--query '.shellescape(<q-args>) . ' '
      \         . '--with-nth=2.. '
      \         . '--nth=2.. '
      \         . '--delimiter=":"'
      \     },
      \     'down:50%'
      \   )
      \ )

" ファイル名の一覧をfzfで絞り込む
nnoremap <F9> :FzfFiles<CR>
nnoremap <C-p> :FzfFiles<CR>
command! -bang -nargs=? -complete=dir FzfFiles
      \ call fzf#run(
      \   fzf#vim#with_preview(
      \     fzf#wrap(
      \       {
      \         'dir': s:GetDir(<q-args>),
      \         'source': 'rg '
      \           .'--files '
      \           .'--no-ignore '
      \           .'--hidden '
      \           .'--binary '
      \           .'--glob !.git/ '
      \           .'--glob !.DS_Store '
      \           .'--sort=path'
      \       }
      \     )
      \   )
      \ )

function! s:EditFile(args0)
  let l:list = split(a:args0[0], "\t")
  execute 'edit +' . l:list[2] . ' ' . l:list[1]
endfunction

" ファイルの内容をgit-grep、及びripgrepで検索して、さらにfzfで絞り込む
command! -bang -nargs=* Grep
  \ call fzf#run({
  \   'source': 'unified_grep "' . <q-args> . '"',
  \   'sink*': function('s:EditFile'),
  \   'options': '-m'
  \   . ' --delimiter="\t" '
  \   . ' --tabstop=3 '
  \   . ' --ansi '
  \   . ' --prompt "fzf.vim.vim Grep > " '
  \   . ' --info=inline '
  \   . ' --layout reverse '
  \   . ' --with-nth=1.. '
  \   . ' --nth=1.. '
  \   . ' --bind "tab:execute(git_pull_request_open_by_file_line {2} {3})" '
  \   . ' --bind "ctrl-_:toggle-preview" '
  \   . ' --preview "git_blame_colored {2} {3} ' . shellescape(<q-args>) . ' {q}"'
  \   . ' --preview-window="wrap:down:75%" ',
  \   'window': { 'width': 0.95, 'height': 0.99 }
  \   })

" ファイルの内容をgit-grep、及びripgrepで検索して、さらにfzfで絞り込む
command! -bang -nargs=* GitDeepblame
  \ call fzf#run({
  \   'source': 'git_deepblame "' . <q-args> . '" -- ' . system('git_obtain_relative_path ' . expand('%:p')),
  \   'sink*': function('s:EditFile'),
  \   'options': '-m'
  \   . ' --delimiter="\t" '
  \   . ' --tabstop=3 '
  \   . ' --ansi '
  \   . ' --prompt "fzf.vim.vim GitDeepblame > " '
  \   . ' --info=inline '
  \   . ' --layout reverse '
  \   . ' --with-nth=1.. '
  \   . ' --nth=1.. '
  \   . ' --bind "tab:execute(git_pull_request_open_by_file_line {2} {3})" '
  \   . ' --bind "ctrl-_:toggle-preview" ',
  \   'window': { 'width': 0.95, 'height': 0.99 }
  \   })

function! s:warn(message) abort
    echohl WarningMsg
    echomsg a:message
    echohl None
    return 0
endfunction

function! s:fzf_bufopen(e) abort
    let list = split(a:e)
    if len(list) < 4
        return
    endif

    let [linenr, col, file_text] = [list[1], list[2]+1, join(list[3:])]
    let lines = getbufline(file_text, linenr)
    let path = file_text
    if empty(lines)
        if stridx(join(split(getline(linenr))), file_text) == 0
            let lines = [file_text]
            let path = bufname('%')
        elseif filereadable(path)
            let lines = ['buffer unloaded']
        else
            " Skip.
            return
        endif
    endif

    execute 'e '  . path
    call cursor(linenr, col)
endfunction

function! s:fzf_yank_sink(e) abort
    let @" = a:e
    echohl ModeMsg
    echo 'Yanked!'
    echohl None
endfunction

function! s:fzf_messages_source() abort
    return split(call('execute', ['messages']), '\n')
endfunction

function! s:fzf_messages(bang) abort
    let s:source = 'messages'
    call fzf#run(fzf#wrap('messages', {
                \ 'source':  s:fzf_messages_source(),
                \ 'sink':    function('s:fzf_yank_sink'),
                \ 'options': '+m --prompt "Messages> "',
                \ }, a:bang))
endfunction

command! -bang Messages call <SID>fzf_messages(<bang>0)

function! s:fzf_open_quickfix_item(e) abort
    let line = a:e
    let filename = fnameescape(split(line, ':\d\+:')[0])
    let linenr = matchstr(line, ':\d\+:')[1:-2]
    let colum = matchstr(line, '\(:\d\+\)\@<=:\d\+:')[1:-2]
    execute 'e ' . filename
    call cursor(linenr, colum)
endfunction

function! s:fzf_quickfix_to_grep(v) abort
    return bufname(a:v.bufnr) . ':' . a:v.lnum . ':' . a:v.col . ':' . a:v.text
endfunction

function! s:fzf_get_quickfix() abort
    return map(getqflist(), 's:fzf_quickfix_to_grep(v:val)')
endfunction

function! s:fzf_quickfix(bang) abort
    let s:source = 'quickfix'
    let items = s:fzf_get_quickfix()
    if len(items) == 0
        call s:warn('No quickfix items!')
        return
    endif
    call fzf#run(fzf#wrap('quickfix', {
                \ 'source': items,
                \ 'sink':   function('s:fzf_open_quickfix_item'),
                \ 'options': '--layout=reverse-list --prompt "Quickfix> "'
                \ }, a:bang))
endfunction

function! s:fzf_get_location_list() abort
    return map(getloclist(0), 's:fzf_quickfix_to_grep(v:val)')
endfunction

function! s:fzf_location_list(bang) abort
    let s:source = 'location_list'
    let items = s:fzf_get_location_list()
    if len(items) == 0
        call s:warn('No location list items!')
        return
    endif
    call fzf#run(fzf#wrap('location_list', {
                \ 'source': items,
                \ 'sink':   function('s:fzf_open_quickfix_item'),
                \ 'options': '--layout=reverse-list --prompt "LocationList> "'
                \ }, a:bang))
endfunction

command! -bang Quickfix call s:fzf_quickfix(<bang>0)
command! -bang LocationList call s:fzf_location_list(<bang>0)

function! s:fzf_yank_register(line) abort
    call setreg('"', getreg(a:line[7]))
    echohl ModeMsg
    echo 'Yanked!'
    echohl None
endfunction

function! s:fzf_get_registers() abort
    return split(call('execute', ['registers']), '\n')[1:]
endfunction

function! s:fzf_registers(bang) abort
    let s:source = 'registers'
    let items = s:fzf_get_registers()
    if len(items) == 0
        call s:warn('No register items!')
        return
    endif
    call fzf#run(fzf#wrap('registers', {
                \ 'source':  items,
                \ 'sink':    function('s:fzf_yank_register'),
                \ 'options': '--layout=reverse-list +m --prompt "Registers> "',
                \ }, a:bang))
endfunction

command! -bang Registers call s:fzf_registers(<bang>0)

" ===
" === Jumps list and Change list
" ===
" from https://github.com/junegunn/fzf.vim/issues/865

function GoTo(jumpline)
  let values = split(a:jumpline, ":")
  execute "e ".values[0]
  call cursor(str2nr(values[1]), str2nr(values[2]))
  execute "normal zvzz"
endfunction

function GetLine(bufnr, lnum)
  let lines = getbufline(a:bufnr, a:lnum)
  if len(lines)>0
    return trim(lines[0])
  else
    return ''
  endif
endfunction

function Getjumps()
    let jumps = []
    let raw_jumps = reverse(copy(getjumplist()[0]))
    for it in raw_jumps
        if bufexists(it.bufnr)
            call add(jumps, it)
        endif
    endfor
    return jumps
endfunction

command! Jumps call Jumps()
function! Jumps()
  " Get jumps with filename added
  let tmp_jump = Getjumps()
  if(tmp_jump == [])
        call s:warn('Empty jump list!')
        return
  endif
  let jumps = map(Getjumps(), 
    \ { key, val -> extend(val, {'fname': getbufinfo(val.bufnr)[0].name }) })

  let jumptext = map(copy(jumps), { index, val -> 
    \ (val.fname).':'.(val.lnum).':'.(val.col+1).': '.GetLine(val.bufnr, val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
    \ 'source': jumptext,
    \ 'column': 1,
    \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
    \ 'sink': function('GoTo')})))
endfunction

command! Changes call Changes()
function! Changes()
  let changes  = reverse(copy(getchangelist()[0]))
  if(changes == [])
    call s:warn('Empty change list!')
    return
  endif

  let changetext = map(copy(changes), { index, val -> 
    \ expand('%').':'.(val.lnum).':'.(val.col+1).': '.GetLine(bufnr('%'), val.lnum) })

  call fzf#run(fzf#vim#with_preview(fzf#wrap({
    \ 'source': changetext,
    \ 'column': 1,
    \ 'options': ['--delimiter', ':', '--bind', 'alt-a:select-all,alt-d:deselect-all', '--preview-window', '+{2}-/2'],
    \ 'sink': function('GoTo')})))
endfunction


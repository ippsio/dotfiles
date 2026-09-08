set laststatus=3
let g:lightline = {
  \  'colorscheme': 'Tomorrow',
  \  'inactive': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filepath']
  \    ],
  \    'right': [
  \      ['lineinfo'],
  \      ['filetype_diffOrNot']
  \    ]
  \  },
  \  'active': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filepath']
  \    ],
  \    'right': [
  \      ['md5_selection', 'md5_selection_size'],
  \      ['info'],
  \      ['lineinfo'],
  \      ['filetype_diffOrNot']
  \    ]
  \  },
  \  'component': {
  \    'lineinfo': '%v:%l/%L(%p%%)%<',
  \    'info': join([
  \      '%{%StrGitMergeBase()%}',
  \      '(%{%StrUnderCursor()%} 0x%02B)',
  \      &fileformat . '|' . &fileencoding . '%<'
  \    ], '')
  \  },
  \  'component_function': {
  \    'filetype_diffOrNot': 'FileType_DiffOrNot',
  \    'filetype': 'FileType',
  \    'filepath': 'FileName',
  \    'git': 'StrGitMergeBase',
  \    'md5_selection': 'Md5Selection',
  \    'md5_selection_size': 'Md5SelectionSize',
  \  },
  \ }

function! FileType_DiffOrNot()
  return join([
    \ '(',
    \ 'ft=' . &ft,
    \ &diff ? ',&diff' : '',
    \ ')',
    \ ], '')
endfunction
function! FileName()
  return join([
    \ substitute(expand("%:p"), $HOME, "~", "g"),
    \ ( &modified ? '|+' : ''),
    \ ], '')
endfunction

function! StrUnderCursor()
  return matchstr(getline('.'), '.', col('.')-1)
endfunction

function! StrGitMergeBase()
  return g:gitgutter_diff_base != "" ? '[' . g:gitgutter_diff_base . ']' : ''
endfunction

" ---- md5 of visual selection --------------------------------------------
" statusline の評価中に system() を呼ばないよう、autocmd 側で計算してキャッシュし
" component_function はキャッシュを返すだけにする
let g:lightline_md5_maxbytes = get(g:, 'lightline_md5_maxbytes', 1048576)
let s:md5_selection = ''
let s:md5_selection_size = ''
let s:md5_key = ''

function! s:HumanBytes(n) abort
  if a:n < 1024
    return a:n . 'B'
  elseif a:n < 1048576
    return printf('%.1fK', a:n / 1024.0)
  elseif a:n < 1073741824
    return printf('%.1fM', a:n / 1048576.0)
  else
    return printf('%.1fG', a:n / 1073741824.0)
  endif
endfunction

function! s:Md5SelectionUpdate() abort
  let l:m = mode()
  if l:m !~# "^[vV\<C-v>]"
    let s:md5_selection = ''
    let s:md5_selection_size = ''
        let s:md5_key = ''
    return
  endif
  let l:key = join([l:m, string(getpos('v')), string(getpos('.')), b:changedtick], ',')
  if l:key ==# s:md5_key
    return
  endif
  let s:md5_key = l:key
  let l:text = join(getregion(getpos('v'), getpos('.'), #{ type: l:m }), "\n")
  let l:size = strlen(l:text)
  let s:md5_selection_size = s:HumanBytes(l:size)
  if l:size > g:lightline_md5_maxbytes
    let s:md5_selection = 'md5:too-large'
  else
    let s:md5_selection = 'md5:' . trim(system(['md5', '-q'], l:text))
  endif
endfunction

function! Md5Selection() abort
  return s:md5_selection
endfunction

function! Md5SelectionSize() abort
  return s:md5_selection_size
endfunction

augroup LightlineMd5Selection
  autocmd!
  autocmd ModeChanged,CursorMoved * call s:Md5SelectionUpdate()
augroup END


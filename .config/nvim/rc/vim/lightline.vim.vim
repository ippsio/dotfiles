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


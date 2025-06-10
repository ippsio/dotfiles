set laststatus=3
let g:lightline = {
  \  'colorscheme': 'Tomorrow',
  \  'inactive': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filepath']
  \    ],
  \    'right': [
  \      ['lineinfo']
  \    ]
  \  },
  \  'active': {
  \    'left': [
  \      ['mode', 'paste'],
  \      ['readonly', 'filepath']
  \    ],
  \    'right': [
  \      ['info'],
  \      ['lineinfo']
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
  \    'filepath': 'FileName',
  \    'git': 'StrGitMergeBase',
  \  },
  \ }

function! FileName()
  return join([
    \ substitute(expand("%:p"), $HOME, "~", "g"),
    \ ( &modified ? '|+' : ''),
    \ '(&ft=' . &ft . ')',
    \ ], '')
endfunction

function! StrUnderCursor()
  return matchstr(getline('.'), '.', col('.')-1)
endfunction

function! StrGitMergeBase()
  return g:gitgutter_diff_base != "" ? '[' . g:gitgutter_diff_base . ']' : ''
endfunction


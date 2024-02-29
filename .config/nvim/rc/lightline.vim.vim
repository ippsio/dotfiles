set laststatus=2
let g:lightline = {
  \  'colorscheme': 'Tomorrow',
  \  'inactive': {'left': [ ['mode', 'paste'], ['readonly', 'filepath']], 'right': [ ['lineinfo']] },
  \  'active': {  'left': [ ['mode', 'paste'], ['readonly', 'filepath']], 'right': [ ['info'], ['lineinfo']] },
  \  'component': { 'lineinfo': '%v:%l/%L(%p%%)%<', 'info': '%{%StrGitMergeBase()%}(%{%StrUnderCursor()%} 0x%02B)' . &fileformat . '|' . &fileencoding . '%<'},
  \  'component_function': { 'filepath': 'FileName', 'git': 'StrGitMergeBase'},
  \ }

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
  \ '%dW %dE',
  \ all_non_errors,
  \ all_errors
  \)
endfunction

function! FileName()
  return substitute(expand("%:p"), $HOME, "~", "g") . ( &modified ? '|+' : '')
endfunction

function! StrUnderCursor()
  return matchstr(getline('.'), '.', col('.')-1)
endfunction

function! StrGitMergeBase()
  return g:gitgutter_diff_base != "" ? '[' . g:gitgutter_diff_base . ']' : ''
endfunction


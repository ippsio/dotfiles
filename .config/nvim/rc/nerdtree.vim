nnoremap <C-n> :call NERDTreeFindOrCloseToggle()<CR>

let NERDTreeShowHidden=1
let NERDTreeShowFiles=1

let g:NERDTreeWinSize = 55
let NERDTreeMinimalUI=0
let NERDTreeMinimalMenu=0
let NERDTreeCascadeSingleChildDir=0
let NERDTreeAutoDeleteBuffer=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

function NERDTreeFindOrCloseToggle()
  if &filetype == 'nerdtree'
    :NERDTreeClose
  else
    if expand('%') == ''
      :NERDTreeFocus
    else
      :NERDTreeFind
    endif
  endif
endfunction

nnoremap <C-\> :call MyNerdToggle()<CR>

augroup AU_NERDTree
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
augroup END


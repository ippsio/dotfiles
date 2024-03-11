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
" let NERDTreeMapCustomOpen = 'l'

function NERDTreeFindOrCloseToggle()
  if IsNERDTreeOpen()
    NERDTreeClose
  else
    NERDTreeFind
    wincmd p
  endif
endfunction

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

augroup AU_NERDTree
  " Exit Vim if NERDTree is the only window remaining in the only tab.
  autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

  " Start NERDTree and put the cursor back in the other window.
  autocmd VimEnter * call NERDTreeFindOrCloseToggle() | wincmd p

  " Highlight currently open buffer in NERDTree
  autocmd BufEnter * call SyncTree()
augroup END


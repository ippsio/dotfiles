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
let NERDTreeMapCustomOpen = 'l'
"
let NERDTreeMapCloseDir = 'h'
function! NERDTreeFindOrCloseToggle()
  if IsNERDTreeOpen()
    NERDTreeClose
  elseif winnr('$') == 1
    NERDTreeToggle
    wincmd p
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
  autocmd VimEnter * call NERDTreeFindOrCloseToggle()

  " Highlight currently open buffer in NERDTree
  autocmd BufEnter * call SyncTree()
augroup END

" function to find file under current node
function! NERDTreeFindFile(node)
  if a:node.path.isDirectory == 1
    let path = a:node.path.str()
  else
    let path = a:node.path.getDir().str()
  endif
  echo path
  NERDTreeClose
  call fzf#vim#files(path)
endfunction
" function to grep files under current node
function! NERDTreeGrepFile(node)
  if a:node.path.isDirectory == 1
    let path = a:node.path.str()
  else
    let path = a:node.path.getDir().str()
  endif
  NERDTreeClose
  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case \"\" ".shellescape(path), 1, fzf#vim#with_preview())
endfunction
" function to grep files under current node
function! NERDTreeHoge(node)
  if a:node.path.isDirectory == 1
    let path = a:node.path.str()
  else
    let path = a:node.path.getDir().str()
  endif
  NERDTreeClose
  call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case \"\" ".shellescape(path), 1, fzf#vim#with_preview())
endfunction
augroup nerdtree
  autocmd!
  " find file under current node
  autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'zf',
        \ 'callback': 'NERDTreeFindFile',
        \ 'quickhelpText': 'find file under current node',
        \ 'scope': 'Node' })
  " grep files under current node
  autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'zg',
        \ 'callback': 'NERDTreeGrepFile',
        \ 'quickhelpText': 'grep files under current node',
        \ 'scope': 'Node' })
  autocmd VimEnter * call NERDTreeAddKeyMap({
        \ 'key': 'l',
        \ 'callback': 'NERDTreeHoge',
        \ 'quickhelpText': 'grep files under current node',
        \ 'scope': 'Node' })
augroup END

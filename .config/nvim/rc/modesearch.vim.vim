if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

cmap <C-x> <Plug>(modesearch-toggle-mode)

" Always starts in 'rawstr' mode
nmap ? <Plug>(modesearch-slash-rawstr)


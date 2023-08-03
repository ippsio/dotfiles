if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

" defxを開いた時にハイライトされるのを防ぐ。
let g:extra_whitespace_ignored_filetypes = ['defx']


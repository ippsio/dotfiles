if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

let g:accelerated_jk_acceleration_table = [7,12,17,21,24,26,28,30]
nmap <silent>j <Plug>(accelerated_jk_gj)
nmap <silent>k <Plug>(accelerated_jk_gk)


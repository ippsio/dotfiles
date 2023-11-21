if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

vmap ,d :call ClipDiff()<CR>

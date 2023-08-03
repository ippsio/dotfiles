if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

hi mkdListBlock0 guifg=#55ccff guibg=none ctermfg=14 cterm=bold
hi mkdListBlock1 guifg=#55ccff guibg=none ctermfg=14 cterm=bold

hi htmlH1 ctermbg=61
hi htmlH2 ctermbg=126
hi htmlH3 ctermbg=90
hi htmlH4 ctermbg=131
hi htmlH5 ctermbg=94

hi mkdCode guifg=#ffffff guibg=#666666 ctermbg=236 ctermfg=255
hi mkdCodeDelimiter guifg=#ff6666 guibg=#663333 ctermbg=88 ctermfg=213
hi mkdInlineCodeDelimiter guifg=#ff6666 guibg=#663333

hi mkdBlockquote guifg=#cccccc guibg=#333333 ctermbg=236 ctermfg=255

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_liquid=1
let g:vim_markdown_math=0
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=0
set nofoldenable


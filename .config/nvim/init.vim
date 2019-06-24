filetype off
filetype plugin indent off

runtime! vim_autocmd.vim
runtime! vim_setting.vim
runtime! vim_remaps.vim

syntax enable
runtime! vim_dein.vim
filetype plugin indent on

runtime! vim_hilight.vim

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ 'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
\ <bang>0)

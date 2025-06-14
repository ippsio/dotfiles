" Jetpackでインストールされたプラグインの保存先 ~/.local/share/nvim/site/pack/jetpack/opt
runtime! vars.vim
runtime! settings.vim
runtime! remaps.vim
runtime! autocmds.vim
runtime! jetpack.vim
runtime! highlights.vim
""try
""  runtime! colorscheme.vim
""catch
""endtry
runtime! jetpack_loadrc.vim
runtime! rc/functions/Hi.vim

function! SayVisual()
  silent normal! gv"zy
  call system('say -v Samantha ', @z)
  silent normal! gv
endfunction
vnoremap <silent> <leader>s :<C-u>call SayVisual()<CR>

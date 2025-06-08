" Jetpackでインストールされたプラグインの保存先 ~/.local/share/nvim/site/pack/jetpack/opt
runtime! vars.vim
runtime! settings.vim
runtime! remaps.vim
runtime! jetpack.vim
runtime! autocmds.vim
"runtime! highlights.vim
try
  runtime! colorscheme.vim
  " hi CursorWord ctermbg=144 guibg=#cc0000
catch
endtry
runtime! rc/functions/Hi.vim

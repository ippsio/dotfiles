" Jetpackでインストールされたプラグインの保存先 ~/.local/share/nvim/site/pack/jetpack/opt
runtime! vars.vim
runtime! settings.vim
runtime! remaps.vim
runtime! autocmds.vim
runtime! jetpack.vim
try
  "autocmd VimEnter * colorscheme github_dark_dimmed
catch
endtry
"runtime! jetpack_loadrc.vim
runtime! rc/functions/Hi.vim

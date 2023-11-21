if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

autocmd FileType ruby,slim setlocal dictionary+=~/.cache/dein/repos/github.com/takkii/ruby-dictionary3/autoload/source/ruby_method_deoplete


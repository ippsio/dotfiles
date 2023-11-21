if &compatible
  set nocompatible
endif

let s:jetpackfile = stdpath('data') .. '/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'tani/vim-jetpack', {'opt': 1} "bootstrap
Jetpack 'tpope/vim-fugitive'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'rhysd/conflict-marker.vim'
Jetpack 'itchyny/lightline.vim'
Jetpack 'itchyny/vim-cursorword'
Jetpack 'itchyny/vim-parenmatch'
Jetpack 'cohama/vim-insert-linenr'
Jetpack 'nathanaelkane/vim-indent-guides'
Jetpack 'bronson/vim-trailing-whitespace'
Jetpack 'junegunn/fzf', { 'do': './install --all --no-bash --no-fish --no-zsh' }
Jetpack 'junegunn/fzf.vim'
Jetpack 'Shougo/vimproc.vim', { 'do': 'make' }
Jetpack 'ippsio/clip_diff.vim'
Jetpack 'nvim-treesitter/nvim-treesitter'
Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'leshill/vim-json', { 'for': ['json']}
Jetpack 'rcmdnk/vim-markdown', { 'for': ['markdown']}
Jetpack 'leafgarland/typescript-vim', { 'for': ['js', 'typescript']}
Jetpack 'stephpy/vim-yaml', { 'for': ['yaml']}
Jetpack 'mechatroner/rainbow_csv', { 'for': ['css', 'scss']}
Jetpack 'ap/vim-css-color', { 'for': ['css', 'scss']}
Jetpack 'kchmck/vim-coffee-script', { 'for': ['coffee']}
Jetpack 'vim-ruby/vim-ruby', { 'for': ['ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'tpope/vim-rails'
Jetpack 'vim-scripts/ruby-matchit', { 'for': ['ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'slim-template/vim-slim', { 'for': ['ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'takkii/ruby-dictionary3', { 'for': ['ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'AndrewRadev/splitjoin.vim', { 'for': ['ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'Quramy/tsuquyomi', { 'for': ['js', 'typescript'] }
Jetpack 'nvie/vim-flake8', { 'for': ['python'] }
Jetpack 'tell-k/vim-autopep8', { 'for': ['python'] }
Jetpack 'kana/vim-gf-user', { 'for': ['diff'] }
Jetpack 'kana/vim-gf-diff', { 'for': ['diff'] }
Jetpack 'williamboman/mason.nvim'
Jetpack 'williamboman/mason-lspconfig.nvim'
Jetpack 'neovim/nvim-lspconfig'
Jetpack 'vim-denops/denops.vim'
Jetpack 'Shougo/ddc.vim'
Jetpack 'Shougo/ddc-around'
Jetpack 'Shougo/ddc-file'
Jetpack 'Shougo/ddc-source-nvim-lsp'
Jetpack 'Shougo/ddc-matcher_head'
Jetpack 'Shougo/ddc-sorter_rank'
Jetpack 'Shougo/ddc-converter_remove_overlap'
Jetpack 'tani/ddc-fuzzy'
Jetpack 'Shougo/ddc-ui-native'
Jetpack 'Shougo/ddc-ui-pum'
Jetpack 'Shougo/pum.vim'
Jetpack 'ray-x/lsp_signature.nvim'
Jetpack 'monaqa/modesearch.vim'
Jetpack 'machakann/vim-sandwich'
Jetpack 'terryma/vim-expand-region'
Jetpack 'lambdalisue/fern.vim'
Jetpack 'yuki-yano/fern-preview.vim'

let s:available_pkg = stdpath('data') . '/' . 'site' . '/pack/jetpack/opt/available_packages.json'
let s:available_pkg_text = filereadable(s:available_pkg) ? join(readfile(s:available_pkg)) : "{}"
if sort(jetpack#names()) != sort(keys(json_decode(s:available_pkg_text)))
  call jetpack#sync()
endif

call jetpack#end()

runtime! rc/*.vim rc/*/*.vim


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
" jetpack
Jetpack 'tani/vim-jetpack', { 'opt': 1} "bootstrap

" vim
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Jetpack 'nvim-treesitter/playground', {'do': ':TSPlaygroundToggle'}
Jetpack 'vim-jp/vimdoc-ja'

" ddc
Jetpack 'Shougo/ddc.vim'
Jetpack 'vim-denops/denops.vim'
" ddc> ddc-source
Jetpack 'Shougo/ddc-around'
Jetpack 'Shougo/ddc-source-lsp'
Jetpack 'LumaKernel/ddc-source-file'
" ddc> ddc-matcher,sorter,converter
Jetpack 'Shougo/ddc-filter-converter_remove_overlap'
Jetpack 'Shougo/ddc-sorter_rank'
Jetpack 'Shougo/ddc-matcher_head'
Jetpack 'tani/ddc-fuzzy'
" ddc> ui
Jetpack 'Shougo/ddc-ui-native'
Jetpack 'Shougo/ddc-ui-pum'
Jetpack 'Shougo/pum.vim'

" lsp
" lsp> config
Jetpack 'neovim/nvim-lspconfig'
Jetpack 'williamboman/mason-lspconfig.nvim', {'tag': 'v1.0.0'}
Jetpack 'williamboman/mason.nvim', {'tag': 'v1.0.0'}
Jetpack 'ray-x/lsp_signature.nvim'
" lsp> progress message
Jetpack 'j-hui/fidget.nvim'

" git
Jetpack 'tpope/vim-fugitive'
Jetpack 'airblade/vim-gitgutter'
Jetpack 'iberianpig/tig-explorer.vim'
"Jetpack 'rhysd/conflict-marker.vim'

" viewability, statusline
Jetpack 'itchyny/vim-cursorword'
Jetpack 'itchyny/vim-parenmatch'
Jetpack 'itchyny/lightline.vim'
Jetpack 'bronson/vim-trailing-whitespace'
Jetpack 'cohama/vim-insert-linenr'
"Jetpack 'norcalli/nvim-colorizer.lua'
"Jetpack 'vim-scripts/tango.vim'

" debugger
" Jetpack 'mfussenegger/nvim-dap'
" Jetpack 'mfussenegger/nvim-dap-python'
" Jetpack 'nvim-neotest/nvim-nio'
" Jetpack 'rcarriga/nvim-dap-ui'
" Jetpack 'theHamsta/nvim-dap-virtual-text'

" fzf
Jetpack 'junegunn/fzf', { 'do': './install --all --no-bash --no-fish --no-zsh' }
Jetpack 'junegunn/fzf.vim'

" syntax
Jetpack 'ap/vim-css-color', { 'for': [ 'css', 'scss' ]}
Jetpack 'kchmck/vim-coffee-script', { 'for': [ 'coffee' ]}
Jetpack 'leshill/vim-json', { 'for': [ 'json' ]}
Jetpack 'mechatroner/rainbow_csv', { 'for': [ 'csv', 'tsv' ]}
Jetpack 'stephpy/vim-yaml', { 'for': [ 'yaml' ]}

" text-object selection, surround
Jetpack 'machakann/vim-sandwich'

" ruby development
Jetpack 'AndrewRadev/splitjoin.vim', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'slim-template/vim-slim', { 'for': [ 'slim'] }
Jetpack 'tpope/vim-rails'
Jetpack 'vim-ruby/vim-ruby', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
Jetpack 'vim-scripts/ruby-matchit', { 'for': [ 'ruby', 'rake'] }
Jetpack 'tpope/vim-dispatch'

" file manager
Jetpack 'lambdalisue/fern.vim'
Jetpack 'yuki-yano/fern-preview.vim'

" jump between files
Jetpack 'tpope/vim-projectionist'

"colorscheme
"Jetpack 'bluz71/vim-nightfly-colors'
"Jetpack 'navarasu/onedark.nvim'
"Jetpack 'catppuccin/nvim'
"Jetpack 'olimorris/onedarkpro.nvim'
"Jetpack 'scottmckendry/cyberdream.nvim'
"Jetpack 'lifepillar/vim-colortemplate'

" window
Jetpack 'declancm/maximize.nvim'

" misc
Jetpack 'ippsio/clip_diff.vim'
Jetpack 'monaqa/dial.nvim'

" markdown
"Jetpack 'preservim/vim-markdown'

" outline
Jetpack 'hedyhli/outline.nvim'
Jetpack 'stevearc/aerial.nvim'

" calendar
Jetpack 'itchyny/calendar.vim'

let s:available_pkg = stdpath('data') . '/' . 'site' . '/pack/jetpack/opt/available_packages.json'
let s:available_pkg_text = filereadable(s:available_pkg) ? join(readfile(s:available_pkg)) : "{}"
if sort(jetpack#names()) != sort(keys(json_decode(s:available_pkg_text)))
  call jetpack#sync()
endif

call jetpack#end()


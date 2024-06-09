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
" [jetpack]
Jetpack 'tani/vim-jetpack', { 'opt': 1} "bootstrap
if v:true
  if v:true " ddc
    Jetpack 'Shougo/ddc.vim'
    " required dependency
    Jetpack 'vim-denops/denops.vim'
    " ddc-source
    Jetpack 'Shougo/ddc-around'
    Jetpack 'Shougo/ddc-source-lsp'
    Jetpack 'LumaKernel/ddc-source-file'
    " ddc-matcher,sorter,converter
    Jetpack 'tani/ddc-fuzzy'
    " ui
    Jetpack 'Shougo/ddc-ui-native'
    Jetpack 'Shougo/ddc-ui-pum'
    Jetpack 'Shougo/pum.vim'
  endif
  if v:true " lsp
    "Jetpack 'j-hui/fidget.nvim'
    Jetpack 'neovim/nvim-lspconfig'
    Jetpack 'ray-x/lsp_signature.nvim'
    Jetpack 'williamboman/mason-lspconfig.nvim'
    Jetpack 'williamboman/mason.nvim'
  endif
  if v:true " git
    Jetpack 'tpope/vim-fugitive'
    Jetpack 'airblade/vim-gitgutter'
    Jetpack 'iberianpig/tig-explorer.vim'
    "Jetpack 'rbgrouleff/bclose.vim'
  endif
  if v:true " viewability, statusline
    Jetpack 'itchyny/vim-cursorword'
    Jetpack 'itchyny/vim-parenmatch'
    Jetpack 'itchyny/lightline.vim'
    Jetpack 'bronson/vim-trailing-whitespace'
    Jetpack 'cohama/vim-insert-linenr'
    "Jetpack 'nathanaelkane/vim-indent-guides'
    if v:false " incline
      Jetpack 'b0o/incline.nvim'
      Jetpack 'nvim-tree/nvim-web-devicons'
      Jetpack 'SmiteshP/nvim-navic'
    endif
    if v:true " debugger
      Jetpack 'mfussenegger/nvim-dap'
      Jetpack 'mfussenegger/nvim-dap-python'
      Jetpack 'nvim-neotest/nvim-nio'
      Jetpack 'rcarriga/nvim-dap-ui'
      Jetpack 'theHamsta/nvim-dap-virtual-text'
    endif
  endif
  "  Jetpack 'shellRaining/hlchunk.nvim'
  if v:true " fzf
    Jetpack 'junegunn/fzf', { 'do': './install --all --no-bash --no-fish --no-zsh' }
    Jetpack 'junegunn/fzf.vim'
  endif
  if v:true " syntax
    Jetpack 'ap/vim-css-color', { 'for': [ 'css', 'scss' ]}
    Jetpack 'kchmck/vim-coffee-script', { 'for': [ 'coffee' ]}
    Jetpack 'leshill/vim-json', { 'for': [ 'json' ]}
    Jetpack 'mechatroner/rainbow_csv', { 'for': [ 'css', 'scss' ]}
    "Jetpack 'nvie/vim-flake8', { 'for': [ 'python' ] }
    Jetpack 'rcmdnk/vim-markdown', { 'for': [ 'markdown' ]}
    Jetpack 'stephpy/vim-yaml', { 'for': [ 'yaml' ]}
  endif
  if v:true " gf
    Jetpack 'kana/vim-gf-diff', { 'for': ['diff'] }
    Jetpack 'kana/vim-gf-user', { 'for': ['diff'] }
  endif
  if v:true " text-object selection, surround
    Jetpack 'machakann/vim-sandwich'
    Jetpack 'terryma/vim-expand-region'
  endif
  if v:true " ruby development
    Jetpack 'AndrewRadev/splitjoin.vim', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
    Jetpack 'dense-analysis/ale', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
    Jetpack 'slim-template/vim-slim', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
    Jetpack 'tpope/vim-rails'
    Jetpack 'vim-ruby/vim-ruby', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
    Jetpack 'vim-scripts/ruby-matchit', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
    if v:true
      "Jetpack 'thoughtbot/vim-rspec', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] }
      Jetpack 'tpope/vim-dispatch'
    endif
  endif
  if v:true " filer
    Jetpack 'lambdalisue/fern.vim'
    Jetpack 'yuki-yano/fern-preview.vim'
  endif
  if v:true " cursor
    Jetpack 'echasnovski/mini.animate'
    Jetpack 'kana/vim-smartword'
    Jetpack 'rhysd/accelerated-jk'
  endif
  if v:true " jump between files
    Jetpack 'tpope/vim-projectionist'
  endif
  if v:true " search
    Jetpack 'monaqa/modesearch.vim'
  endif
endif
Jetpack 'rhysd/conflict-marker.vim'
Jetpack 'ippsio/clip_diff.vim'
Jetpack 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'lambdalisue/guise.vim'
Jetpack 'lambdalisue/gin.vim'
Jetpack 'monaqa/dial.nvim'
Jetpack 'folke/which-key.nvim'
if v:true
  Jetpack 'rebelot/kanagawa.nvim'
  Jetpack 'folke/tokyonight.nvim'
  Jetpack 'rktjmp/lush.nvim'
  Jetpack 'ribru17/bamboo.nvim'
  Jetpack 'uloco/bluloco.nvim'
  Jetpack 'kartikp10/noctis.nvim'
  Jetpack 'scottmckendry/cyberdream.nvim'
  Jetpack 'danilo-augusto/vim-afterglow'
  Jetpack 'romainl/Apprentice'
endif
let s:available_pkg = stdpath('data') . '/' . 'site' . '/pack/jetpack/opt/available_packages.json'
let s:available_pkg_text = filereadable(s:available_pkg) ? join(readfile(s:available_pkg)) : "{}"
if sort(jetpack#names()) != sort(keys(json_decode(s:available_pkg_text)))
  call jetpack#sync()
endif

call jetpack#end()

let s:rc_vim = split(glob(expand('<script>:h') . '/rc/vim/*.vim'))
let s:rc_lua = split(glob(expand('<script>:h') . '/rc/lua/*.lua'))
for s:rcfile_realpath in (s:rc_vim + s:rc_lua)
  if jetpack#tap(fnamemodify(s:rcfile_realpath, ':t:r'))
    execute 'runtime! rc/' . fnamemodify(s:rcfile_realpath, ':e') . '/' . fnamemodify(s:rcfile_realpath, ':t')
  else
    " echomsg 'Jetpackは' . s:plugin . 'を認識してません。' . s:rcfile_full . 'はruntime!しません。'
  endif
endfor

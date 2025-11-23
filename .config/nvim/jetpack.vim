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
call jetpack#add('tani/vim-jetpack', { 'opt': 1 })

" vim
call jetpack#add('nvim-treesitter/nvim-treesitter', { 'on_event': 'VimEnter', 'do': ':TSUpdate', })
call jetpack#add('nvim-treesitter/playground', { 'do': ':TSUpdate', 'on': ['TSPlaygroundToggle', 'TSHighlightCapturesUnderCursor'] })

call jetpack#add('vim-jp/vimdoc-ja', { 'on_event': 'VimEnter' })
" ddc
call jetpack#add('vim-denops/denops.vim', { 'hook_source': 'source $HOME/.config/nvim/rc/vim/denops.vim.vim', })
call jetpack#add('Shougo/ddc.vim', { 'on_event': ['InsertEnter', 'InsertLwave'], 'depends': [ 'vim-denops/denops.vim' ], 'hook_source': 'source $HOME/.config/nvim/rc/vim/ddc.vim.vim', })
" ddc> ddc-source
call jetpack#add('Shougo/ddc-around', { 'on_event': 'VimEnter', })
call jetpack#add('Shougo/ddc-source-lsp', { 'on_event': 'VimEnter', })
call jetpack#add('LumaKernel/ddc-source-file', { 'on_event': 'VimEnter', })
" ddc> ddc-matcher,sorter,converter
call jetpack#add('Shougo/ddc-filter-converter_remove_overlap', { 'on_event': 'VimEnter', })
call jetpack#add('Shougo/ddc-sorter_rank', { 'on_event': 'VimEnter', })
call jetpack#add('Shougo/ddc-matcher_head', { 'on_event': 'VimEnter', })
call jetpack#add('tani/ddc-fuzzy', { 'on_event': 'VimEnter', })
" ddc> ui
call jetpack#add('Shougo/ddc-ui-native', { 'on_event': 'VimEnter', })
call jetpack#add('Shougo/ddc-ui-pum', { 'on_event': 'VimEnter', })
call jetpack#add('Shougo/pum.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/pum.vim.vim', })

" lsp
" lsp> config
call jetpack#add('williamboman/mason.nvim', { 'on_event': 'VimEnter' })
call jetpack#add('neovim/nvim-lspconfig', { 'on_event': 'VimEnter', })
call jetpack#add('williamboman/mason-lspconfig.nvim', {
      \ 'on_event': 'VimEnter',
      \ 'hook_source': 'source $HOME/.config/nvim/rc/lua/nvim-lspconfig.lua',
      \ 'depends': [ 'williamboman/mason.nvim', 'neovim/nvim-lspconfig', 'ray-x/lsp_signature.nvim' ],
      \ })
call jetpack#add('ray-x/lsp_signature.nvim', { 'on_event': 'VimEnter', })
"" lsp> progress message
call jetpack#add('j-hui/fidget.nvim', { 'on_event': 'VimEnter', })
call jetpack#add('SmiteshP/nvim-navic', { 'on_event': 'VimEnter', })

" git
call jetpack#add('tpope/vim-fugitive', { 'on_cmd': ['Git'] })
call jetpack#add('airblade/vim-gitgutter', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/vim-gitgutter.vim', })
call jetpack#add('iberianpig/tig-explorer.vim', { 'on_event': 'VimEnter', })

call jetpack#add('rhysd/conflict-marker.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/conflict-marker.vim.vim', })

" viewability, statusline
call jetpack#add('itchyny/vim-cursorword', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/vim-cursorword.vim', })
call jetpack#add('itchyny/vim-parenmatch', { 'on_event': 'VimEnter', })
call jetpack#add('itchyny/lightline.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/lightline.vim.vim', })
call jetpack#add('bronson/vim-trailing-whitespace', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/vim-trailing-whitespace.vim', })
call jetpack#add('cohama/vim-insert-linenr', { 'on_event': 'VimEnter', })
call jetpack#add('norcalli/nvim-colorizer.lua', { 'on_event': 'VimEnter', })

" fzf
call jetpack#add('junegunn/fzf', { 'do': './install --all --no-bash --no-fish --no-zsh', })
call jetpack#add('junegunn/fzf.vim', { 'on_event': 'VimEnter', 'depends': ['junegunn/fzf'], 'hook_source': 'source $HOME/.config/nvim/rc/vim/fzf.vim.vim', })

" syntax
call jetpack#add('ap/vim-css-color', { 'for': [ 'css', 'scss' ] })
call jetpack#add('kchmck/vim-coffee-script', { 'for': ['coffee'], })
call jetpack#add('leshill/vim-json', { 'for': ['json'], })
call jetpack#add('stephpy/vim-yaml', { 'for': ['yaml'], })

" text-object selection, surround
call jetpack#add('machakann/vim-sandwich', { 'on_event': 'VimEnter', })

" ruby development
call jetpack#add('AndrewRadev/splitjoin.vim', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] })
call jetpack#add('slim-template/vim-slim', { 'for': [ 'slim'] })
call jetpack#add('tpope/vim-rails', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] })
call jetpack#add('vim-ruby/vim-ruby', { 'for': [ 'ruby', 'rake', 'eruby', 'slim'] })
call jetpack#add('vim-scripts/ruby-matchit', { 'for': [ 'ruby', 'rake'] })
call jetpack#add('tpope/vim-dispatch', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/vim-dispatch.vim', })
call jetpack#add('thoughtbot/vim-rspec', {'on_event': 'VimEnter'})

" file manager
call jetpack#add('lambdalisue/fern.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/fern.vim.vim', })

call jetpack#add('yuki-yano/fern-preview.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/fern-preview.vim.vim', })

" jump between files
call jetpack#add('tpope/vim-projectionist', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/vim-projectionist.vim', })

"colorscheme
call jetpack#add('projekt0n/github-nvim-theme', { 'on_event': 'VimEnter', })

" misc
call jetpack#add('ippsio/clip_diff.vim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/vim/clip_diff.vim.vim', })
call jetpack#add('monaqa/dial.nvim', { 'on_event': 'VimEnter', 'hook_source': 'source $HOME/.config/nvim/rc/lua/dial.nvim.lua', })

" vim_abolish
call jetpack#add('tpope/vim-abolish', { 'on_event': 'VimEnter', })

call jetpack#add('github/copilot.vim', { 'on_cmd': ['Copilot'], })
" ChatGPT
call jetpack#add('jackMort/ChatGPT.nvim', {
      \ 'on_cmd': ['ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun'],
      \ 'depends': [
      \   'MunifTanjim/nui.nvim',
      \   'folke/trouble.nvim',
      \   'nvim-lua/plenary.nvim',
      \   'nvim-telescope/telescope.nvim',
      \ ],
      \ 'hook_source': 'source $HOME/.config/nvim/rc/lua/ChatGPT.nvim.lua',
      \ })
call jetpack#add('MunifTanjim/nui.nvim', { 'on_cmd': ['ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun'], })
call jetpack#add('folke/trouble.nvim', { 'on_cmd': ['ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun'], })
call jetpack#add('nvim-lua/plenary.nvim', { 'on_cmd': ['ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun'], })
call jetpack#add('nvim-telescope/telescope.nvim', { 'on_cmd': ['ChatGPT', 'ChatGPTActAs', 'ChatGPTCompleteCode', 'ChatGPTEditWithInstructions', 'ChatGPTRun'], })
" ChatGPT

let s:available_pkg = stdpath('data') . '/' . 'site' . '/pack/jetpack/opt/available_packages.json'
let s:available_pkg_text = filereadable(s:available_pkg) ? join(readfile(s:available_pkg)) : "{}"
if sort(jetpack#names()) != sort(keys(json_decode(s:available_pkg_text)))
  call jetpack#sync()
endif

call jetpack#end()

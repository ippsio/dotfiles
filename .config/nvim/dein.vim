if &compatible
  set nocompatible
endif

"neovim + vim
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
Jetpack 'rhysd/accelerated-jk'
Jetpack 'junegunn/fzf', { 'do': {-> fzf#install()} }
Jetpack 'junegunn/fzf.vim'
Jetpack 'Shougo/vimproc.vim'
Jetpack 'ippsio/clip_diff.vim'
Jetpack 'nvim-treesitter/nvim-treesitter'
Jetpack 'Shougo/defx.nvim'
Jetpack 'tpope/vim-repeat'
Jetpack 'kana/vim-operator-user'
Jetpack 'kana/vim-operator-replace'
Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'leshill/vim-json', { 'on_ft': ['json']}
Jetpack 'rcmdnk/vim-markdown', { 'on_ft': ['markdown']}
Jetpack 'leafgarland/typescript-vim', { 'on_ft': ['js', 'typescript']}
Jetpack 'stephpy/vim-yaml', { 'on_ft': ['yaml']}
Jetpack 'mechatroner/rainbow_csv', { 'on_ft': ['css', 'scss']}
Jetpack 'ap/vim-css-color', { 'on_ft': ['css', 'scss']}
Jetpack 'stsewd/tree-sitter-rst', { 'on_ft': ['rst']}
Jetpack 'kchmck/vim-coffee-script', { 'on_ft': ['coffee']}
Jetpack 'dense-analysis/ale'
Jetpack 'vim-ruby/vim-ruby', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'tpope/vim-rails', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'vim-scripts/ruby-matchit', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'slim-template/vim-slim', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'takkii/ruby-dictionary3', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'AndrewRadev/splitjoin.vim', { 'on_ft': ['ruby', 'rake', 'erb', 'slim'] }
Jetpack 'Quramy/tsuquyomi', { 'on_ft': ['js', 'typescript'] }
Jetpack 'nvie/vim-flake8', { 'on_ft': ['python'] }
Jetpack 'tell-k/vim-autopep8', { 'on_ft': ['python'] }
Jetpack 'kana/vim-gf-user', { 'on_ft': 'diff' }
Jetpack 'kana/vim-gf-diff', { 'on_ft': 'diff' }
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

let array = []
"call insert(array, '/Users/i/.config/nvim/toml/git_vim-fugitive.toml')
"call insert(array, '/Users/i/.config/nvim/toml/git_vim-gitgutter.toml')
"call insert(array, '/Users/i/.config/nvim/toml/git_conflict-marker.toml')
"call insert(array, '/Users/i/.config/nvim/toml/statusline_lightline.toml')
"call insert(array, '/Users/i/.config/nvim/toml/visual_vim-cursorword.toml')
"call insert(array, '/Users/i/.config/nvim/toml/visual_vim-parenmatch.toml')
"call insert(array, '/Users/i/.config/nvim/toml/visual_vim-insert-linenr.toml')
"call insert(array, '/Users/i/.config/nvim/toml/visual_vim-indent-guides.toml')
"call insert(array, '/Users/i/.config/nvim/toml/visual_vim-trailing-whitespace.toml')
"call insert(array, '/Users/i/.config/nvim/toml/cursor_accelerated-jk.toml')
"call insert(array, '/Users/i/.config/nvim/toml/fzf.toml')
"call insert(array, '/Users/i/.config/nvim/toml/vimproc.toml')
"call insert(array, '/Users/i/.config/nvim/toml/diff_clip_diff.toml')
"call insert(array, '/Users/i/.config/nvim/toml/syntax_nvim-treesitter.toml')
"for toml_file in array
"  call jetpack#load_toml(toml_file)
"endfor

let array = []
"call insert(array, '/Users/i/.config/nvim/toml/0_filemanage.toml')
"call insert(array, '/Users/i/.config/nvim/toml/0_misc.toml')
"call insert(array, '/Users/i/.config/nvim/toml/doc_vimdoc-ja.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_syntax.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_linter.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_rb.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_typescript.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_py.toml')
"call insert(array, '/Users/i/.config/nvim/toml/git_vim-gf-diff.toml')
"call insert(array, '/Users/i/.config/nvim/toml/1_lsp.toml')
"call insert(array, '/Users/i/.config/nvim/toml/ddc.toml')
"call insert(array, '/Users/i/.config/nvim/toml/ddc_source.toml')
"call insert(array, '/Users/i/.config/nvim/toml/ddc_filter.toml')
"call insert(array, '/Users/i/.config/nvim/toml/ddc_ui.toml')
"for toml_file in array
"  call jetpack#load_toml(toml_file, {lazy: 1})
"endfor

"lua <<EOF
"require'nvim-treesitter.configs'.setup {
"  highlight = {
"    enable = true,
"    disable = { }
"  }
"}
"EOF


" if has('nvim')
"   call dein#remote_plugins()
" endif

call jetpack#end()
runtime! rc/**/*.vim

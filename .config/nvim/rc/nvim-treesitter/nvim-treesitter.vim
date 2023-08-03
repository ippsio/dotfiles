if !jetpack#tap(expand('<sfile>:t:r')) | finish | endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { }
  }
}
EOF


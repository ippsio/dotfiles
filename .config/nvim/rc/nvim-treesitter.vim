if !jetpack#tap(expand('<script>:t:r'))
  finish " このファイル名に該当するプラグインがJetpack上で有効でない場合finishします
endif

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = { }
  }
}
EOF


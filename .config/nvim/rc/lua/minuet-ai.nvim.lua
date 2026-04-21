require('minuet').setup({
  provider = 'claude',
  provider_options = {
    claude = {
      model = 'claude-haiku-4-5-20251001',
      max_tokens = 256,
      stream = true,
    },
  },
  virtualtext = {
    auto_trigger_ft = { '*' },
    keymap = {
      accept = '<C-y>',
      accept_line = '<C-l>',
      next = '<C-n>',
      prev = '<C-p>',
      dismiss = '<C-]>',
    },
  },
})

-- 遅延ロード時、既に開いているバッファにも自動トリガーを有効化
vim.b.minuet_virtual_text_auto_trigger = true

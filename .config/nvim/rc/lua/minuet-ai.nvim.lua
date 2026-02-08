require('minuet').setup({
  provider = 'claude',
  provider_options = {
    claude = {
      model = 'claude-haiku-4.5-20241022',
      max_tokens = 256,
      stream = true,
    },
  },
  virtualtext = {
    auto_trigger_ft = {},
    keymap = {
      accept = '<A-A>',
      accept_line = '<A-a>',
      next = '<A-]>',
      prev = '<A-[>',
      dismiss = '<A-e>',
    },
  },
})

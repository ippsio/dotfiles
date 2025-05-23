local neotest = require('neotest')

neotest.setup({
  adapters = {
    require('neotest-python')({
      dap = { justMyCode = false }  -- デバッグ用設定
    }),
  },
})


local dap = require('dap')
local dapui = require('dapui')

dapui.setup()

-- neotestのdap設定
require('neotest').setup({
  adapters = {
    require('neotest-python')({
      dap = { justMyCode = false },
    }),
  },
})

-- キーバインディングの設定例
vim.api.nvim_set_keymap('n', '<F5>', '<cmd>lua require"dap".continue()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F12>', '<cmd>lua require"dap".step_out()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dr', '<cmd>lua require"dap".repl.open()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua require"dap".run_last()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })

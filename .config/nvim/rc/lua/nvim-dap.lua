local venv = os.getenv('VIRTUAL_ENV')
local command = string.format('%s/bin/python', venv)
local handle = io.popen("which python") -- Python 3 のパスを取得
if handle ~= nil then
  local result = handle:read("*a")
  handle:close()
  result = result:gsub("%s+", "") -- 結果の改行を削除
  command = result
end
-- print(command)

-- debugpyモジュールが必要です (pip install debugpy)
require('dap-python').setup(command)
vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dr', ':lua require("dap").repl.open()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>dl', ':lua require("dap").run_last()<CR>', { silent = true })

vim.api.nvim_set_keymap('n', '<leader>d', ':lua require("dapui").toggle()<CR>', {})

require("dapui").setup({
  --  icons = { expanded = "", collapsed = "" },
  --  layouts = {
  --    {
  --      elements = {
  --        { id = "watches", size = 0.20 },
  --        { id = "stacks", size = 0.20 },
  --        { id = "breakpoints", size = 0.20 },
  --        { id = "scopes", size = 0.40 },
  --      },
  --      size = 64,
  --      position = "right",
  --    },
  --    {
  --      elements = {
  --        "repl",
  --        "console",
  --      },
  --      size = 0.20,
  --      position = "bottom",
  --    },
  --  },
})
require 'dap'.listeners.before['event_initialized']['custom'] = function(session, body)
  require 'dapui'.open()
end
--require 'dap'.listeners.before['event_terminated']['custom'] = function(session, body)
--  require 'dapui'.close()
--end


require("nvim-dap-virtual-text").setup {
  enabled = true,                       -- enable this plugin (the default)
  enabled_commands = true,              -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
  highlight_changed_variables = true,   -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
  highlight_new_as_changed = false,     -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
  show_stop_reason = true,              -- show stop reason when stopped for exceptions
  commented = false,                    -- prefix virtual text with comment string
  only_first_definition = true,         -- only show virtual text at first definition (if there are multiple)
  all_references = false,               -- show virtual text on all all references of the variable (not only definitions)
  clear_on_continue = false,            -- clear virtual text on "continue" (might cause flickering when stepping)
  --- A callback that determines how a variable is displayed or whether it should be omitted
  --- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
  --- @param buf number
  --- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
  --- @param node userdata tree-sitter node identified as variable definition of reference (see `:h tsnode`)
  --- @param options nvim_dap_virtual_text_options Current options for nvim-dap-virtual-text
  --- @return string|nil A text how the virtual text should be displayed or nil, if this variable shouldn't be displayed
  display_callback = function(variable, buf, stackframe, node, options)
    if options.virt_text_pos == 'inline' then
      return ' = ' .. variable.value
    else
      return variable.name .. ' = ' .. variable.value
    end
  end,
  -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
  virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

  -- experimental features:
  all_frames = false,       -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
  virt_lines = false,       -- show virtual lines instead of virtual text (will flicker!)
  virt_text_win_col = nil   -- position the virtual text at a fixed window column (starting from the first text column) ,
  -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}

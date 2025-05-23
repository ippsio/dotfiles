require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "denols",
    "bashls",
    "vimls",
    "lua_ls",
    "pylsp",
    "solargraph",
    --"rubocop",
    "sqlls",
    "jdtls"
  }
})

require("mason-lspconfig").setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup({
      require "lsp_signature".setup({
        debug = false, -- set to true to enable debug logging
        --log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
        -- default is  ~/.cache/nvim/lsp_signature.log
        verbose = false, -- show debug line number

        bind = false, -- This is mandatory, otherwise border config won't get registered.
                    -- If you want to hook lspsaga or other signature handler, pls set to false
        doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                      -- set to 0 if you DO NOT want any API comments be shown
                      -- This setting only take effect in insert mode, it does not affect signature help in normal
                      -- mode, 10 by default

        max_height = 12, -- max height of signature floating_window
        max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                        -- the value need >= 40
        wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
        floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

        floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
        -- will set to true when fully tested, set to false will use whichever side has more space
        -- this setting will be helpful if you do not want the PUM and floating win overlap

        floating_window_off_x = 1, -- adjust float windows x position.
                                  -- can be either a number or function
        floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                                    -- can be either number or function, see examples

        close_timeout = 4000, -- close floating window after ms when laster parameter is entered
        fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
        hint_enable = true, -- virtual hint enable
        hint_prefix = "↙",  -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
        -- or, provide a table with 3 icons
        -- hint_prefix = {
        --     above = "↙ ",  -- when the hint is on the line above the current line
        --     current = "← ",  -- when the hint is on the same line
        --     below = "↖ "  -- when the hint is on the line below the current line
        -- }
        hint_scheme = "String",
        hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
        -- return true | 'inline' to show hint inline, return 'eol' to show hint at end of line, return false to disable
        -- return 'right_align' to display hint right aligned in the current line
        hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
        handler_opts = {
          border = "single"   -- double, rounded, single, shadow, none, or a table of borders
        },

        always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

        auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
        --extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
        zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

        padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

        transparency = nil, -- disabled by default, allow floating win transparent value 1~100
        shadow_blend = 36, -- if you using shadow as border use this set the opacity
        shadow_guibg = 'Green', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
        timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
        toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
        toggle_key_flip_floatwin_setting = false, -- true: toggle floating_windows: true|false setting after toggle key pressed
          -- false: floating_windows setup will not change, toggle_key will pop up signature helper, but signature
          -- may not popup when typing depends on floating_window setting

        select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
        move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating window
        -- e.g. move_cursor_key = '<M-p>',
        -- once moved to floating window, you can use <M-d>, <M-u> to move cursor up and down
        keymaps = {}  -- relate to move_cursor_key; the keymaps inside floating window
        -- e.g. keymaps = { 'j', '<C-o>j' } this map j to <C-o>j in floating window
        -- <M-d> and <M-u> are default keymaps to move cursor up and down
      }),
    })
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["pylsp"] = function()
    require("lspconfig").pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              enabled = true,
              -- pycodestyle https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
              --ignore = { "E501", "W391" },
              maxLineLength = 30
            },
            mccabe = {
              enabled = true,
            },
            autopep8 = {
              enabled = true,
            },
            napf = {
              enabled = true,
            },
            mypy = {
              enabled = true,
            }
          }
        }
      }
    }
  end,
  ["lua_ls"] = function()
    require("lspconfig").lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
  ["denols"] = function()
    require("lspconfig").denols.setup({
      capabilities = require("ddc_source_lsp").make_client_capabilities()
    })
  end,
  ["solargraph"] = function()
    require("lspconfig").solargraph.setup {
      settings = {
        solargraph = {
          diagnostics = false
        }
      }
    }
  end,
  --["rubocop"] = function()
  --  require("lspconfig").rubocop.setup {
  --    cmd = { "bundle", "exec", "rubocop", "--lsp" },
  --    root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
  --  }
  --end,
  ["bashls"] = function()
    require("lspconfig").bashls.setup {
      cmd = { "node", "--experimental-wasm-reftypes", vim.fn.stdpath("data") .. "/mason/packages/bash-language-server/node_modules/.bin/bash-language-server", "start" },
    }
  end,
  -- ["markdown_oxide"] = function()
  --   require("lspconfig").markdown_oxide.setup({
  --     default_config = {
  --       cmd = { "markdown-oxide" },
  --       filetypes = { "markdown" },
  --       --root_dir = util.root_pattern(".git", "."),
  --     }
  --   })
  -- end,



})

-- Global mappings.
--[[
See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
]]

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    --vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    --[[
    次の指摘へ進む vim.diagnostic.goto_next
    前の指摘へ戻る vim.diagnostic.goto_prev
    指摘を一覧表示する vim.diagnostic.setloclist
    宣言へジャンプする vim.lsp.buf.declaration
    定義へジャンプする vim.lsp.buf.definition
    情報を表示する vim.lsp.buf.hover
    実装へジャンプする vim.lsp.buf.implementation
    シグニチャのヘルプを表示する vim.lsp.buf.signature_help
    ワークスペースに現在のフォルダを追加する vim.lsp.buf.add_workspace_folder
    ワークスペースから現在のフォルダを取り除く vim.lsp.buf.remove_workspace_folder
    ワークスペースを出力する function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end
    型の定義へジャンプする vim.lsp.buf.type_definition
    リネームする vim.lsp.buf.rename
    指摘に対するアクションの候補を表示する vim.lsp.buf.code_action
    参照している箇所を一覧表示する vim.lsp.buf.references
    ファイル全体をフォーマットする function() vim.lsp.buf.format { async = true } end
    インレイヒントの表示を切り替える function() vim.lsp.buf.inlay_hint(bufnr) end
    ]]

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<f3>', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    --vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<f8>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
    -- vim.cmd [[
    --   augroup LspHover
    --     autocmd!
    --     autocmd CursorHold,CursorHoldI * lua vim.lsp.buf.hover(opts)
    --   augroup END
    -- ]]
  end,
})

vim.diagnostic.enable(true)
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = {
    format = function(diagnostic)
      return string.format(
        "(source=%s,code=%s) %s",
        diagnostic.source,
        diagnostic.code,
        diagnostic.message
      )
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "!e",
      [vim.diagnostic.severity.WARN] = "!w",
      [vim.diagnostic.severity.INFO] = "!i",
      [vim.diagnostic.severity.HINT] = "!h",
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = "hl-DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "hl-DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "hl-DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "hl-DiagnosticSignHint",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "hl-DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "hl-DiagnosticSignWarn",
      [vim.diagnostic.severity.INFO] = "hl-DiagnosticSignInfo",
      [vim.diagnostic.severity.HINT] = "hl-DiagnosticSignHint",
    },
  },
})

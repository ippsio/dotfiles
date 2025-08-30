-- nvim-navic の設定
local navic = require("nvim-navic")
--navic.setup({
--  highlight = true,
--  icons = {
--    File          = "",
--    Module        = "",
--    Namespace     = "ns:",
--    Package       = "",
--    Class         = "class:",
--    Method        = "method:",
--    Property      = "",
--    Field         = "",
--    Constructor   = "",
--    Enum          = "",
--    Interface     = "",
--    Function      = "",
--    Variable      = "",
--    Constant      = "",
--    String        = "",
--    Number        = "",
--    Boolean       = "",
--    Array         = "",
--    Object        = "",
--    Key           = "",
--    Null          = "",
--    EnumMember    = "",
--    Struct        = "",
--    Event         = "",
--    Operator      = "",
--    TypeParameter = "D ",
--  },
--})

-- winbar を有効にし、nvim-navic が提供する文字列を表示
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

---

-- MasonとMason-LSPconfigのセットアップ
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "denols",
    "bashls",
    "vimls",
    "lua_ls",
    "pylsp",
    "solargraph",
    "sqlls",
    "jdtls"
  }
})

-- 署名ヘルプ (lsp_signature) の設定は、
local lsp_signature_opts = {
  debug = false,
  verbose = false,
  bind = false, -- This is mandatory, otherwise border config won't get registered.
  doc_lines = 10,
  max_height = 12,
  max_width = 120,
  wrap = true,
  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = 1,
  floating_window_off_y = 0,
  close_timeout = 4000,
  fix_pos = false,
  hint_enable = true,
  hint_prefix = "↙",
  hint_scheme = "String",
  hint_inline = function() return false end,
  hi_parameter = "LspSignatureActiveParameter",
  handler_opts = {
    border = "single"
  },
  always_trigger = false,
  auto_close_after = nil,
  zindex = 200,
  padding = '',
  transparency = nil,
  shadow_blend = 36,
  shadow_guibg = 'Green',
  timer_interval = 200,
  toggle_key = nil,
  toggle_key_flip_floatwin_setting = false,
  select_signature_key = nil,
  move_cursor_key = nil,
  keymaps = {}
}

-- すべてのLSPサーバーに共通で適用したい設定（例: lsp_signature の設定を on_attach で適用）
-- nvim-cmp を使用している場合は capabilities を追加することもできます
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- if require("cmp_nvim_lsp").default_capabilities then
--   capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- end

vim.lsp.config('*', {
  on_attach = function(client, bufnr)
    -- lsp_signature の設定を LSP サーバーがアタッチされたときに適用
    require("lsp_signature").on_attach(lsp_signature_opts, bufnr)

    -- nvim-navic の初期化
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end

    -- Buffer local mappings.
    local opts = { buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<f8>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
  capabilities = capabilities,
})

-- 特定のLSPサーバーのカスタム設定
vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
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
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

vim.lsp.config("denols", {
  -- ddc_source_lsp を使用している場合
  -- capabilities = require("ddc_source_lsp").make_client_capabilities()
})

vim.lsp.config("solargraph", {
  settings = {
    solargraph = {
      diagnostics = false
    }
  }
})

--[[
-- "rubocop" がコメントアウトされているのでそのまま
vim.lsp.config("rubocop", {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
})
]]

vim.lsp.config("bashls", {
  cmd = { "node", "--experimental-wasm-reftypes", vim.fn.stdpath("data") .. "/mason/packages/bash-language-server/node_modules/.bin/bash-language-server", "start" },
})

-- Diagnostic の設定
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

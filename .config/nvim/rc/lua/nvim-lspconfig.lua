-- winbar を有効にし、nvim-navic が提供する文字列を表示
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

-- MasonとMason-LSPconfigのセットアップ
require("mason").setup()

local navic = require("nvim-navic")
local capabilities = vim.lsp.protocol.make_client_capabilities()
vim.lsp.config('*', {
  on_attach = function(client, bufnr)
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

vim.lsp.config("pylsp", {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 30,
          --ignore = { "E501", "W391" },
        },
        mccabe = { enabled = true, },
        autopep8 = { enabled = true, },
        napf = { enabled = true, },
        mypy = { enabled = true, }
      }
    }
  }
})
vim.lsp.enable("pylsp")

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
})

vim.lsp.config("ruby-lsp", {
  cmd = { "rbenv", "exec", "ruby-lsp"},
  filetypes = { 'ruby', 'eruby' },
  root_markers = { 'Gemfile', '.git'}
})
vim.lsp.enable("ruby-lsp")

vim.lsp.config("rubocop", {
  cmd = { "bundle", "exec", "rubocop", "--lsp" },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
})

vim.lsp.config("bashls", {
  cmd = {
    "node",
    vim.fn.stdpath("data") .. "/mason/packages/bash-language-server/node_modules/.bin/bash-language-server",
    "start"
  },
})
vim.lsp.enable("bashls")

vim.lsp.config("ts_ls", {
  filetypes = { 'javascript' },
})
vim.lsp.enable("ts_ls")

-- Diagnostic の設定
vim.diagnostic.enable(true)
vim.diagnostic.config({
  update_in_insert = true,
  virtual_text = {
    format = function(diagnostic)
      return string.format(
        "(%s->%s) %s",
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

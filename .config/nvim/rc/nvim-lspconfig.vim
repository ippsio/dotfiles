lua << EOF
local mason_lspconfig_setup_opts = {
  ensure_installed = {
    "bashls",
    "vimls",
    "lua_ls",
    "pylsp",
    "solargraph",
    "tsserver",
    "sqlls",
    "jdtls"
  }
}
local lsp_signature_on_attach_opts = {
  bind = false,
  use_lspsaga = true,
  floating_window = true,
  fix_pos = true,
  hint_enable = true,
  hi_parameter = "Search",
  handler_opts = {
    "shadow"
  }
}

local mason_lspconfig_setup_handlers_opts = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup {
      require "lsp_signature".on_attach(lsp_signature_on_attach_opts)
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  --["rust_analyzer"] = function ()
  --    require("rust-tools").setup {}
  --end,
  --["lua_ls"] = function ()
  --    local lspconfig = require("lspconfig")
  --    lspconfig.lua_ls.setup {
  --        settings = {
  --            Lua = {
  --                diagnostics = {
  --                    globals = { "vim" }
  --                }
  --            }
  --        }
  --    }
  --end,
}
require("mason").setup()
require("mason-lspconfig").setup(mason_lspconfig_setup_opts)
require("mason-lspconfig").setup_handlers(mason_lspconfig_setup_handlers_opts)


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
EOF

lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach =
  function (client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }
  end

require("mason").setup()

local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
  ensure_installed = {
    'vimls',
    'pylsp',
    'solargraph',
    'tsserver',
    'sqlls',
    'jdtls'
  }
}
mason_lspconfig.setup_handlers({
  function(server_name)
  local opts = {}
    opts.on_attach = function(_, bufnr)
      local bufopts = { silent = true, buffer = bufnr }
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', 'gtD', vim.lsp.buf.type_definition, bufopts)
      --vim.keymap.set('n', 'grf', vim.lsp.buf.references, bufopts)
      --vim.keymap.set('n', '<space>p', vim.lsp.buf.format, bufopts)
      --vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      --vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      --vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      --vim.keymap.set('n', 'gx', vim.lsp.diagnostic.show_line_diagnostics, bufopts)
      --vim.keymap.set('n', 'g[', vim.lsp.diagnostic.goto_prev, bufopts)
      --vim.keymap.set('n', 'g]', vim.lsp.diagnostic.goto_next, bufopts)
     end
  nvim_lsp[server_name].setup(opts)
  end})
EOF


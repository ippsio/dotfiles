local capabilities = require("ddc_source_lsp").make_client_capabilities()
require("lspconfig").denols.setup({
  capabilities = capabilities,
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "vimls",
    "lua_ls",
    "pylsp",
    "rubocop",
    "solargraph",
    "tsserver",
    "sqlls",
    "jdtls",
  }
})
local mason_lspconfig_setup_handlers_opts = {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    require("lspconfig")[server_name].setup {
      require "lsp_signature".on_attach({
        bind = false,
        use_lspsaga = true,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = { "shadow" }
      })
    }
  end,
  -- Next, you can provide targeted overrides for specific servers.
  -- pycodestyle
  -- E101:Indentation contains mixed spaces and tabs
  -- E111:Indentation is not a multiple of four
  -- E112:Expected an indented block
  -- E113:Unexpected indentation
  -- E114:Indentation is not a multiple of four (comment)
  -- E115:Expected an indented block (comment)
  -- E116:Unexpected indentation (comment)
  -- E117:Over-indented
  -- E121:Continuation line under-indented for hanging indent
  -- E122:Continuation line missing indentation or outdented
  -- E123:Closing bracket does not match indentation of opening bracket's line
  -- E124:Closing bracket does not match visual indentation
  -- E125:Continuation line with same indent as next logical line
  -- E126:Continuation line over-indented for hanging indent
  -- E127:Continuation line over-indented for visual indent
  -- E128:Continuation line under-indented for visual indent
  -- E129:Visually indented line with same indent as next logical line
  -- E131:Continuation line unaligned for hanging indent
  -- E133:Closing bracket is missing indentation
  -- E201:Whitespace after '('
  -- E202:Whitespace before ')'
  -- E203:Whitespace before ':'
  -- E211:Whitespace before '('
  -- E221:Multiple spaces before operator
  -- E222:Multiple spaces after operator
  -- E223:Tab before operator
  -- E224:Tab after operator
  -- E225:Missing whitespace around operator
  -- E226:Missing whitespace around arithmetic operator
  -- E227:Missing whitespace around bitwise or shift operator
  -- E228:Missing whitespace around modulo operator
  -- E231:Missing whitespace after ',', ';', or ':'
  -- E241:Multiple spaces after ','
  -- E242:Tab after ','
  -- E251:Unexpected spaces around keyword / parameter equals
  -- E261:At least two spaces before inline comment
  -- E262:Inline comment should start with '# '
  -- E265:Block comment should start with '# '
  -- E266:Too many leading '#' for block comment
  -- E271:Multiple spaces after keyword
  -- E272:Multiple spaces before keyword
  -- E273:Tab after keyword
  -- E274:Tab before keyword
  -- E275:Missing whitespace after keyword
  -- E301:Expected 1 blank line, found 0
  -- E302:Expected 2 blank lines, found 0
  -- E303:Too many blank lines (3)
  -- E304:Blank lines found after function decorator
  -- E305:Expected 2 blank lines after end of function or class
  -- E306:Expected 1 blank line before a nested definition
  -- E401:Multiple imports on one line
  -- E402:Module level import not at top of file
  -- E501:Line too long (82 > 79 characters)
  -- E502:The backslash is redundant between brackets
  -- E701:Multiple statements on one line (colon)
  -- E702:Multiple statements on one line (semicolon)
  -- E703:Statement ends with a semicolon
  -- E704:Multiple statements on one line (def)
  -- E711:Comparison to None should be 'cond is None:'
  -- E712:Comparison to true should be 'if cond is true:' or 'if cond:'
  -- E713:Test for membership should be 'not in'
  -- E714:Test for object identity should be 'is not'
  -- E721:Do not compare types, use 'isinstance()'
  -- E722:Do not use bare except, specify exception instead
  -- E731:Do not assign a lambda expression, use a def
  -- E741:Do not use variables named 'I', 'O', or 'l'
  -- E742:Do not define classes named 'I', 'O', or 'l'
  -- E743:Do not define functions named 'I', 'O', or 'l'
  -- E901:SyntaxError or IndentationError
  -- E902:IOError
  -- E999:SyntaxError
  -- W191:Indentation contains tabs
  -- W291:Trailing whitespace
  -- W292:No newline at end of file
  -- W293:Blank line contains whitespace
  -- W391:Blank line at end of file
  -- W503:Line break occurred before a binary operator
  -- W504:Line break occurred after a binary operator
  -- W601:.has_key() is deprecated, use 'in'
  -- W602:Deprecated form of raising exception
  -- W603:'<>' is deprecated, use '!='
  -- W604:Backticks are deprecated, use 'repr()'
  -- W605:Invalid escape sequence 'x'
  ["pylsp"] = function()
    require("lspconfig").pylsp.setup {
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              enabled = true,
              ignore = { "E501", "W391" },
              maxLineLength = 30
            }
          }
        }
      }
    }
  end,
  ["lua_ls"] = function()
    local lspconfig = require("lspconfig")
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end,
  --["rust_analyzer"] = function ()
  --    require("rust-tools").setup {}
  --end,
}

require("mason-lspconfig").setup_handlers(mason_lspconfig_setup_handlers_opts)

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
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<f2>', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<f8>', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

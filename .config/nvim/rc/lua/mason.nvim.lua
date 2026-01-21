require("mason").setup()

local mason_registry = require("mason-registry")
local ensure_installed = {
  "bash-language-server",
  "gopls",
  "lua-language-server",
  "pyright",
  "ruby-lsp",
  "typescript-language-server",
}

for _, name in ipairs(ensure_installed) do
  local p = mason_registry.get_package(name)
  if not p:is_installed() then
    p:install()
  end
end

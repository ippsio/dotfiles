require("mason").setup()

local mason_registry = require("mason-registry")
local ensure_installed = {
  "bash-language-server",
  "lua-language-server",
  "pyright",
  "ruby-lsp",
  "typescript-language-server",
}

local packages = mason_registry.get_all_packages()
if #packages == 0 then
  print("Mason registry is empty or not yet fetched.")
  vim.cmd("MasonUpdate")
end

for _, name in ipairs(ensure_installed) do
  local ok, p = pcall(mason_registry.get_package, name)
  if ok and p and not p:is_installed() then
    print("Installing lsp '" .. name .. "'")
    p:install()
  end
end

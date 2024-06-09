function extend_default(tbl)
  local copy = {}
  for _idx, v in pairs(tbl['default']) do
    table.insert(copy, v)
  end
  return copy
end

local augend = require("dial.augend")
local t = {
  default = {
    augend.integer.alias.decimal,
    augend.constant.alias.bool,    -- boolean value (true <-> false)
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
  }
}
local extend_default_ar = {'python', 'ruby', 'visual'}
for _idx, k in ipairs(extend_default_ar) do
  t[k] = extend_default(t)
end

table.insert(t['python'], augend.constant.new{ elements = {"True", "False"} })
table.insert(t['visual'], augend.constant.alias.alpha)
table.insert(t['visual'], augend.constant.alias.Alpha)

require("dial.config").augends:register_group(t)

-- change augends in VISUAL mode
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual("visual"), {noremap = true})
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual("visual"), {noremap = true})

for k, _ in pairs(t) do
  if k ~= 'default' and k ~= 'visual' then
    vim.api.nvim_create_autocmd("FileType", {
      pattern = k,
      callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal(k), { noremap = true })
        vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal(k), { noremap = true })
      end,
    })
  end
end

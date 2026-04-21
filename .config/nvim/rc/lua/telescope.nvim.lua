local telescope = require('telescope')

telescope.setup {
    defaults = {
        layout_config = {
            width = 0.96,
            height = 0.96,
        },
        file_ignore_patterns = {
            "%.git/",
            "%vendor",
        },
    },
    --pickers = {
    --    find_files = {
    --        theme = "dropdown",
    --        hidden = true,
    --    },
    --},
}

local vim = vim
vim.api.nvim_set_keymap('n', '<Leader>ff', "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', ';',          "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })

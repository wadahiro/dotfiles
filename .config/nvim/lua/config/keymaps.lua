-- ========================================
-- Keymaps
-- ========================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Prefix keys
keymap("n", "m", "<Nop>", opts)
keymap("x", "m", "<Nop>", opts)
keymap("n", "z", "<Nop>", opts)
keymap("x", "z", "<Nop>", opts)

-- Note: coc.nvim and plugin-specific keymaps are defined in their respective plugin config files

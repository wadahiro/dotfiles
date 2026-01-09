-- ========================================
-- Basic Options
-- ========================================

local opt = vim.opt

-- Line numbers
opt.number = true

-- Indentation
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Search
opt.hlsearch = true

-- Colors
opt.termguicolors = true

-- Shell
opt.shell = "/bin/bash"
vim.env.SHELL = "/bin/bash"

-- File type detection
vim.cmd("filetype plugin indent on")

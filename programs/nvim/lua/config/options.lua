-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Set highlight on search
vim.o.hlsearch = false

-- Indentation settings
vim.o.tabstop = 4
-- shiftwidth and softtabstop should be the same as tabstop
vim.o.shiftwidth = 0
vim.o.softtabstop = -1
vim.o.autoindent = true
vim.o.breakindent = true

-- Linebreak settings
vim.o.linebreak = true

-- Enable word wrap
vim.wo.wrap = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set colorscheme
vim.o.termguicolors = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Do not conceal!
vim.o.conceallevel = 0

-- Do not show invisible characters
vim.opt.list = false

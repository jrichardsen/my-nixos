-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local file_type_indent_group = vim.api.nvim_create_augroup('file_type_indent', { clear = true });

vim.api.nvim_create_autocmd('FileType', {
    group = file_type_indent_group,
    pattern = { 'nix' },
    callback = function()
        vim.opt_local.ts = 2
        -- Workaround for https://github.com/ryan4yin/nix-config/issues/4
        -- vim.opt_local.smartindent = false
    end,
})

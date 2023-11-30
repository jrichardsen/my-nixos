return {
  -- add more lsp servers
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      format = {
        timeout_ms = 5000,
      },
      servers = {
        rust_analyzer = {},
        texlab = {
          settings = {
            texlab = {
              build = {
                args = { "-pdf", "-view=pdf", "-interaction=nonstopmode", "--shell-escape", "-synctex=1", "%f" },
                onSave = true,
                forwardSearchAfter = true,
              },
              forwardSearch = {
                executable = "zathura",
                args = { "--synctex-forward", "%l:1:%f", "%p" },
              },
            },
          },
        },
      },
    },
  },
  -- Plugin for Jupyter Notebooks
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    event = "BufWinEnter *.ju.py",
    config = function()
      local jupynium = require("jupynium")
      jupynium.setup({})
      jupynium.set_default_keymaps()
      require("jupynium.textobj").set_default_keymaps()
    end,
    keys = {
      { "<leader>ji", "<cmd>JupyniumStartAndAttachToServer<cr>", desc = "Jupynium start and attach to server" },
      { "<leader>js", "<cmd>JupyniumStartSync<cr>", desc = "Jupynium start sync" },
      { "<leader>jS", "<cmd>JupyniumStopSync<cr>", desc = "Jupynium stop sync" },
      { "<leader>jr", "<cmd>JupyniumStopSync<cr><cmd>JupyniumStartSync<cr>", desc = "Jupynium restart sync" },
      { "<leader>jl", "<cmd>JupyniumLoadFromIpynbTab 2<cr>", desc = "Jupynium load from tab" },
      {
        "<leader>jL",
        "<cmd>JupyniumLoadFromIpynbTabAndStartSync 2<cr>",
        desc = "Jupynium load from tab and start sync",
      },
    },
  },
}

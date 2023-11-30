return {
  {
    "alexghergh/nvim-tmux-navigation",
    opts = {},
    keys = {
      { "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", desc = "Move to left window" },
      { "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", desc = "Move to lower window" },
      { "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", desc = "Move to upper window" },
      { "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", desc = "Move to right window" },
      { "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", desc = "Move to last window" },
      { "<C-Space>", "<Cmd>NvimTmuxNavigateNext<CR>", desc = "Move to next window" },
    },
  },
}

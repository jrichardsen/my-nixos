{
  config,
  utils,
  lib,
  ...
}:
{
  config = {
    keymaps = [
      (utils.mkCmdMapN "<leader>bb" "<cmd>edit #<cr>" "Switch to oher buffer")
      (utils.mkLuaMapN "<leader>bd" ''function() require("mini.bufremove").delete(0, false) end''
        "Delete buffer"
      )
      (utils.mkCmdMapN "<leader>bD" "<cmd>bdelete<cr>" "Delete buffer and window")
      (utils.mkCmdMapN "<leader>bp" "<cmd>BufferLineTogglePin<cr>" "Toggle Pin")
      (utils.mkCmdMapN "<leader>bP" "<cmd>BufferLineGroupClose ungrouped<cr>" "Delete Non-Pinned Buffers")
      (utils.mkCmdMapN "<leader>bo" "<cmd>BufferLineCloseOthers<cr>" "Delete Other Buffers")
      (utils.mkCmdMapN "<leader>bl" "<cmd>BufferLineCloseRight<cr>" "Delete Buffers to the Right")
      (utils.mkCmdMapN "<leader>bh" "<cmd>BufferLineCloseLeft<cr>" "Delete Buffers to the Left")
      (utils.mkCmdMapN "<S-h>" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
      (utils.mkCmdMapN "<S-l>" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
      (utils.mkCmdMapN "[b" "<cmd>BufferLineCyclePrev<cr>" "Prev Buffer")
      (utils.mkCmdMapN "]b" "<cmd>BufferLineCycleNext<cr>" "Next Buffer")
      (utils.mkCmdMapN "[B" "<cmd>BufferLineMovePrev<cr>" "Move buffer prev")
      (utils.mkCmdMapN "]B" "<cmd>BufferLineMoveNext<cr>" "Move buffer next")
    ];
    plugins.mini.modules.bufremove = { };
    plugins.bufferline = {
      enable = true;
      settings.options = {
        always_show_bufferline = false;
        close_command = lib.nixvim.mkRaw ''function(n) require("mini.bufremove").delete(n, false) end'';
        diagnostics = "nvim_lsp";
        diagnostics_indicator =
          let
            icons = config.style.symbols.diagnostics;
          in
          ''
            function(_, _, diag)
              local ret = (diag.error and "${icons.error}" .. diag.error .. " " or "")
                .. (diag.warning and "${icons.warn}" .. diag.warning or "")
              return vim.trim(ret)
            end
          '';
      };
    };
  };
}

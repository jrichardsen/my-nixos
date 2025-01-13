{ pkgs, utils, ... }:
{
  opts = {
    breakindent = true;
    expandtab = true;
    shiftwidth = 2;
    autoindent = true;
    tabstop = 2;
  };

  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "│";
        tab_char = "│";
      };
      scope = {
        show_start = false;
        show_end = false;
      };
      exclude.filetypes = [ "dashboard" ];
    };
  };

  keymaps = [
    (utils.mkLuaMapN "<leader>ug" ''
      function()
        local enabled = require("ibl.config").get_config(0).enabled
        require("ibl").setup_buffer(0, { enabled = not enabled })
      end
    '' "Toggle Indentation guides")
  ];

  extraPlugins = with pkgs.vimPlugins; [ vim-sleuth ];
}

{ config, lib, ... }:
{
  config = {
    plugins.statuscol = {
      enable = true;
      settings = {
        reculright = true;
        segments = [
          {
            sign = {
              name = [ ".*" ];
              namespace = [ ".*" ];
            };
          }
          {
            text = [
              (lib.nixvim.mkRaw "require('statuscol.builtin').lnumfunc")
              " "
            ];
            condition = [
              true
              (lib.nixvim.mkRaw "require('statuscol.builtin').not_empty")
            ];
          }
          {
            sign = {
              namespace = [ "gitsign" ];
              colwidth = 1;
            };
          }
        ];
      };
    };

    plugins.marks.enable = true;

    plugins.gitsigns = {
      enable = true;
      settings =
        let
          symbols = config.style.symbols.gitsigns;
          signs = {
            add = {
              text = symbols.add;
            };
            change = {
              text = symbols.change;
            };
            delete = {
              text = symbols.delete;
            };
            topdelete = {
              text = symbols.topdelete;
            };
            changedelete = {
              text = symbols.changedelete;
            };
            untracked = {
              text = symbols.untracked;
            };
          };
        in
        {
          inherit signs;
          signs_staged = signs;
          attach_to_untracked = true;
        };
    };
  };
}

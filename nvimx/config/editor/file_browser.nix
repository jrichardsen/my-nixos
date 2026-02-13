{
  config,
  utils,
  lib,
  ...
}:
{
  config = {
    plugins.oil = {
      enable = true;
      settings = {
        # HACK: an empty list counts as an empty value and will not be added to
        # the lua translation, therefore use a list with a raw empty object
        # instead.
        columns = [ (if config.style.icons.enable then "icon" else { __raw = ""; }) ];
        keymaps = {
          "<leader>f?" = "actions.show_help";
          "-" = "actions.parent";
          "<leader>fq" = "actions.close";
          "<CR>" = "actions.select";
          "<leader>f-" = "actions.select_split";
          "<leader>f|" = "actions.select_vsplit";
          "<leader>ft" = "actions.select_tab";
          "<leader>fp" = "actions.preview";
          "<leader>fr" = "actions.refresh";
          _ = "actions.open_cwd";
          "`" = "actions.cd";
          "~" = "actions.tcd";
          "<leader>f." = "actions.toggle_hidden";
          "<leader>f\\" = "actions.toggle_trash";
          "<leader>fs" = "actions.change_sort";
          "<leader>fd" = {
            desc = "Toggle detail view";
            callback = lib.nixvim.mkRaw ''
              function()
                local oil = require("oil")
                local config = require("oil.config")
                if #config.columns <= 1 then
                  oil.set_columns({${
                    if config.style.icons.enable then " \"icon\"," else ""
                  } "permissions", "size", "mtime" })
                else
                  oil.set_columns({${if config.style.icons.enable then " \"icon\"" else ""} })
                end
              end
            '';
          };
          "<leader>fx" = "actions.open_external";
        };
        use_default_keymaps = false;
      };
    };

    keymaps = [ (utils.mkCmdMapN "-" "<cmd>Oil<cr>" "Open parent directory") ];
  };
}

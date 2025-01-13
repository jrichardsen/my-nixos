{ lib, config, ... }:
{
  config = {
    opts.showmode = false;
    plugins.lualine =
      let
        symbols = config.style.symbols;
        enableIcons = config.style.icons.enable;
      in
      {
        enable = true;
        settings = {
          options = {
            icons_enabled = enableIcons;
            disabled_filetypes.statusline = [ "dashboard" ];
            globalstatus = config.opts.laststatus == 3;
          };
          sections = {
            lualine_a = [ "mode" ];
            lualine_b = [ "branch" ];
            lualine_c = [
              {
                __unkeyed-1 = "diagnostics";
                symbols = {
                  error = symbols.diagnostics.error;
                  warn = symbols.diagnostics.warn;
                  info = symbols.diagnostics.info;
                  hint = symbols.diagnostics.hint;
                };
              }
              (lib.mkIf enableIcons {
                __unkeyed-1 = "filetype";
                icon_only = true;
                separator = "";
                padding = {
                  left = 2;
                  right = 0;
                };
              })
              {
                __unkeyed-1 = "filename";
                path = 1;
                symbols = {
                  modified = symbols.file.modified;
                  readonly = symbols.file.readonly;
                  unnamed = symbols.file.unnamed;
                };
              }
            ];
            lualine_x = [
              {
                __unkeyed-1 = "diff";
                symbols = {
                  added = symbols.git.added;
                  modified = symbols.git.modified;
                  removed = symbols.git.removed;
                };
              }
            ];
            lualine_y = [ "progress" ];
            lualine_z = [ "location" ];
          };
        };
      };
  };
}

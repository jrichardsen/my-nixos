{ lib, ... }:
{
  imports = [
    ./autocompletions.nix
    ./comments.nix
    ./formatting.nix
    ./git.nix
    ./diagnostics.nix
    ./languages
    ./lsp.nix
    ./indentation.nix
  ];

  config = {
    plugins = {
      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 500;
            custom_textobjects = {
              o = lib.nixvim.mkRaw ''
                require("mini.ai").gen_spec.treesitter({
                  a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                  i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                })
              '';
              f = lib.nixvim.mkRaw ''
                require("mini.ai").gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" })
              '';
              c = lib.nixvim.mkRaw ''
                require("mini.ai").gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" })
              '';
            };
          };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";

              suffix_last = "p";
            };
          };
        };
      };
      treesitter = {
        enable = true;
        settings = {
          indent.enable = true;
          highlight.enable = true;
          incremental_selection = {
            enable = true;
            keymaps = {
              init_selection = "<c-space>";
              node_incremental = "<c-space>";
              scope_incremental = false;
              node_decremental = "<bs>";
            };
          };
        };
      };
      treesitter-textobjects.enable = true;
    };
  };
}

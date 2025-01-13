{ config, ... }:
{
  config = {
    plugins.which-key = {
      enable = true;
      settings = {
        icons.mappings = config.style.icons.enable;
        spec =
          let
            register = keys: desc: {
              __unkeyed-1 = keys;
              inherit desc;
            };
          in
          [
            (register "<leader>b" "[B]uffers")
            (register "<leader>c" "[C]ode")
            (register "<leader>s" "[S]earch")
            (register "<leader>w" "[W]indows")
          ];
      };
    };
  };
}

{ utils, ... }:
{
  config = {
    plugins.persistence = {
      enable = true;
    };

    keymaps = [
      (utils.mkLuaMapN "<leader>qs" ''function() require("persistence").load() end'' "Restore Session")
      (utils.mkLuaMapN "<leader>ql" ''function() require("persistence").load({ last = true }) end''
        "Restore Last Session"
      )
      (utils.mkLuaMapN "<leader>qd" ''function() require("persistence").stop() end''
        "Don't Save Current Session"
      )
    ];
  };
}

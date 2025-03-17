{ utils, config, ... }:
{
  config = {
    keymaps = [
      (utils.mkCmdMapN "<leader>st" "<cmd>TodoTelescope<cr>" "[S]earch [T]odo")
      (utils.mkCmdMapN "<leader>sT" "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>" "[S]earch [T]odo/Fix/Fixme")
      (utils.mkLuaMapN "]t" ''require("todo-comments").jump_next'' "Next [T]odo")
      (utils.mkLuaMapN "[t" ''require("todo-comments").jump_prev'' "Previous [T]odo")
    ];

    plugins.comment.enable = true;
    plugins.todo-comments = {
      enable = true;
      settings.keywords =
        let
          symbols = config.style.symbols.comments;
        in
        {
          FIX.icon = symbols.fix;
          TODO.icon = symbols.todo;
          HACK.icon = symbols.hack;
          WARN.icon = symbols.warn;
          PERF.icon = symbols.perf;
          NOTE.icon = symbols.note;
          TEST.icon = symbols.test;
        };
    };
  };
}

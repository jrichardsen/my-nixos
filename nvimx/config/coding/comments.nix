{ utils, config, ... }:
{
  config = {
    keymaps = [
      (utils.mkCmdMapN "<leader>st" "<cmd>TodoTelescope<cr>" "Todo")
      (utils.mkCmdMapN "<leader>sT" "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>" "Todo/Fix/Fixme")
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

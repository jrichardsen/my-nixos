{ utils, ... }:
{
  config = {
    plugins.tmux-navigator = {
      enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = "<C-w>";
        options.desc = "Windows";
        options.remap = true;
      }
      (utils.mkCmdMapN "<leader>-" "<C-w>s" "Split Window Below")
      (utils.mkCmdMapN "<leader>|" "<C-w>v" "Split Window Right")
      (utils.mkCmdMapN "<leader>wd" "<C-w>q" "Delete Window")
      (utils.mkCmdMapN "<C-Up>" "<cmd>resize +2<cr>" "Increase Window Height")
      (utils.mkCmdMapN "<C-Down>" "<cmd>resize -2<cr>" "Decrease Window Height")
      (utils.mkCmdMapN "<C-Left>" "<cmd>vertical resize -2<cr>" "Decrease Window Width")
      (utils.mkCmdMapN "<C-Right>" "<cmd>vertical resize +2<cr>" "Increase Window Width")
    ];
  };
}

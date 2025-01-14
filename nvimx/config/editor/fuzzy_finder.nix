{ config, utils, ... }:
{
  config = {
    plugins.telescope = {
      enable = true;
      extensions = {
        fzf-native.enable = true;
        ui-select.enable = true;
      };
      settings.pickers =
        let
          setDevicons = {
            disable_devicons = !config.style.icons.enable;
          };
        in
        {
          buffers = setDevicons;
          find_files = setDevicons;
          grep_string = setDevicons;
          live_grep = setDevicons;
          oldfiles = setDevicons;
        };
      keymaps =
        let
          mkMap = action: desc: {
            inherit action;
            options = {
              inherit desc;
            };
          };
        in
        {
          "<leader><leader>" = mkMap "find_files" "[ ] Find files";
          "<leader>sb" = mkMap "buffers" "[S]earch [B]uffers";
          "<leader>se" = mkMap "builtin" "[S]earch T[e]lescope";
          "<leader>sf" = mkMap "find_files" "[S]earch [F]iles";
          "<leader>sg" = mkMap "live_grep" "[S]earch by [G]rep";
          "<leader>sh" = mkMap "help_tags" "[S]earch [H]elp";
          "<leader>sk" = mkMap "keymaps" "[S]earch [K]eymaps";
          "<leader>s." = mkMap "oldfiles" "[S]earch Recent Files (\".\" for repeat)";
          "<leader>sr" = mkMap "resume" "[S]earch [R]esume";
          "<leader>sw" = mkMap "grep_string" "[S]earch current [W]ord";
          "<leader>sm" = mkMap "man_pages" "[S]earch [M]an Pages";
        };
    };
    keymaps = [
      (utils.mkLuaMapN "<leader>/" ''
        function()
          require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end
      '' "[/] Fuzzily search in current buffer")
      (utils.mkLuaMapN "<leader>s/" ''
        function()
          require('telescope.builtin').live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end
      '' "[S]earch [/] in Open Files")
    ];
  };
}

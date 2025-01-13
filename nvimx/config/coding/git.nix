{ helpers, utils, ... }:
{
  config = {
    # NOTE: lazygit integration
    # NOTE: explore how diff mode works
    plugins = {
      fugitive.enable = true;
      gitsigns = {
        enable = true;
        settings.on_attach = helpers.mkRaw ''
          function(buffer)
            local gs = package.loaded.gitsigns

            local function map(mode, l, r, desc)
              vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
            end

            map("n", "]h", function()
              if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
              else
                gs.nav_hunk("next")
              end
            end, "Next Hunk")
            map("n", "[h", function()
              if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
              else
                gs.nav_hunk("prev")
              end
            end, "Prev Hunk")
            map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
            map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
            map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
            map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
            map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
            map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
            map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
            map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
            map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
            map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
            map("n", "<leader>ghd", gs.diffthis, "Diff This")
            map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
          end
        '';
      };
    };
    keymaps = [
      (utils.mkLuaMapN "<leader>gc" "function() require('telescope.builtin').git_commits() end"
        "[G]it [C]ommits"
      )
      (utils.mkLuaMapN "<leader>gC" "function() require('telescope.builtin').git_bcommits() end"
        "[G]it [C]ommits (current file)"
      )
      (utils.mkLuaMapN "<leader>gs" "function() require('telescope.builtin').git_status() end"
        "[G]it [S]tatus"
      )
    ];
  };
}

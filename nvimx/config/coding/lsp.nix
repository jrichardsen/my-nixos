{ utils, config, ... }:
{
  config = {
    plugins = {
      lsp = {
        enable = true;
        onAttach = ''
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = bufnr,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = bufnr,
              callback = vim.lsp.buf.clear_references,
            })
          end
        '';
        capabilities = "capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())";
        keymaps.extra = [
          (utils.mkLuaMapN "gd" "require('telescope.builtin').lsp_definitions" "[G]oto [D]efinition")
          (utils.mkLuaMapN "gD" "vim.lsp.buf.declaration" "[G]oto [D]eclaration")
          (utils.mkLuaMapN "gr" "require('telescope.builtin').lsp_references" "[G]oto [R]eferences")
          (utils.mkLuaMapN "gI" "require('telescope.builtin').lsp_implementations" "[G]oto [I]mplementations")
          (utils.mkLuaMapN "gy" "require('telescope.builtin').lsp_type_definitions"
            "[G]oto T[y]pe Definitions"
          )
          (utils.mkLuaMapN "<leader>ss" "require('telescope.builtin').lsp_document_symbols"
            "[S]earch [S]ymbols (document)"
          )
          (utils.mkLuaMapN "<leader>sS" "require('telescope.builtin').lsp_workspace_symbols"
            "[S]earch [S]ymbols (workspace)"
          )
          (utils.mkLuaMapN "<leader>ca" "vim.lsp.buf.code_action" "[C]ode [A]ction")
          (utils.mkLuaMapN "<leader>cr" "vim.lsp.buf.rename" "[C]ode [R]ename")
          (utils.mkLuaMapN "K" "vim.lsp.buf.hover" "Hover Documentation")
        ];
      };
      lspkind.enable = config.style.icons.enable;
      fidget.enable = true;
    };
  };
}

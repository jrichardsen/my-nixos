{
  config = {
    plugins = {
      cmp = {
        enable = true;
        settings = {
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
          completion.completeopt = "menu,menuone,noinsert,noselect";
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<CR>" = "cmp.mapping.confirm()";
            "<S-CR>" = "cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace }";
            "<C-y>" = "cmp.mapping.confirm { select = true }";
            "<C-Space>" = "cmp.mapping.complete {}";
            # NOTE: do we need snippet expansion?
            "<C-l>" = "function() 
              if require('luasnip').locally_jumpable(1) then
                require('luasnip').jump(1)
              end
            end";
            "<C-h>" = "function() 
              if require('luasnip').locally_jumpable(-1) then
                require('luasnip').jump(-1)
              end
            end";
            "<C-j>" = "function()
              if require('luasnip').choice_active() then
                require('luasnip').change_choice(1)
              end
            end";
            "<C-k>" = "function()
              if require('luasnip').choice_active() then
                require('luasnip').change_choice(-1)
              end
            end";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
          ];
        };
      };
      lspkind.cmp.enable = true;
      luasnip.enable = true;
      friendly-snippets.enable = true;
    };
  };
}

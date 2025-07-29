{ utils, ... }:
{
  config = {
    opts.formatoptions = "jcroqlnt";

    plugins.conform-nvim = {
      enable = true;
      settings = {
        formatters_by_ft = {
          # Formatters to run for filetypes that do not have other formatters configured
          "_" = [ "trim_whitespace" ];
        };
        default_format_opts.lsp_format = "fallback";
      };
    };
    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    plugins.lsp.keymaps.extra = [
      (utils.mkLuaMapN "<leader>cf" "function() require('conform').format { async = true } end"
        "[C]ode [F]ormat"
      )
    ];
  };
}

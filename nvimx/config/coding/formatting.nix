{ utils, ... }:
{
  # NOTE: formatting of injected languages
  config = {
    opts.formatoptions = "jcroqlnt";

    plugins.conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
        # Formatters to run for filetypes that do not have other formatters configured
        "_" = [ "trim_whitespace" ];
      };
    };
    opts.formatexpr = "v:lua.require'conform'.formatexpr()";

    plugins.lsp.keymaps.extra = [
      (utils.mkLuaMapN "<leader>cf"
        "function() require('conform').format { async = true, lsp_fallback = true } end"
        "[C]ode [F]ormat"
      )
    ];
  };
}

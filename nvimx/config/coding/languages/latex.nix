{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.latex;
in
with lib;
{
  options = {
    languages.latex = {
      enable = mkEnableOption "LaTeX language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.texlab = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
      settings = {
        texlab = {
          build = {
            args = [
              "-pdf"
              "-view=pdf"
              "-interaction=nonstopmode"
              "--shell-escape"
              "-synctex=1"
              "%f"
            ];
            onSave = true;
            forwardSearchAfter = true;
          };
          forwardSearch = {
            executable = "zathura";
            args = [
              "--synctex-forward"
              "%l:1:%f"
              "%p"
            ];
          };
        };
      };
    };
    plugins.conform-nvim.settings.formatters_by_ft.tex = [
      (if cfg.bundleTooling then "${pkgs.tex-fmt}/bin/tex-fmt" else "tex-fmt")
    ];
  };
}

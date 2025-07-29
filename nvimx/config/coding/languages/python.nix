{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.python;
in
with lib;
{
  options = {
    languages.python = {
      enable = mkEnableOption "Python language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.pyright = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
    };
    plugins.conform-nvim.settings.formatters_by_ft.python = [
      (if cfg.bundleTooling then "${pkgs.isort}/bin/isort" else "isort")
      (if cfg.bundleTooling then "${pkgs.black}/bin/black" else "black")
    ];
  };
}

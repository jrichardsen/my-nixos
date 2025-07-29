{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.haskell;
in
with lib;
{
  options = {
    languages.haskell = {
      enable = mkEnableOption "Haskell language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.hls = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
      installGhc = mkDefault cfg.bundleTooling;
    };
    plugins.conform-nvim.settings.formatters_by_ft.haskell = [
      (if cfg.bundleTooling then "${pkgs.ormolu}/bin/ormolu" else "ormolu")
    ];
  };
}

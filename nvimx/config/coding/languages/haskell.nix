{ lib, config, ... }:
let
  cfg = config.languages.haskell;
in
with lib;
{
  # NOTE: improve language support
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
  };
}

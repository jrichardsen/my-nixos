{ lib, config, ... }:
let
  cfg = config.languages.c;
in
with lib;
{
  options = {
    languages.c = {
      enable = mkEnableOption "C/C++ language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.clangd = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
    };
  };
}

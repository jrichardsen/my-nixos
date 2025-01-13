{ lib, config, ... }:
let
  cfg = config.languages.rust;
in
with lib;
{
  # NOTE: improve language support
  options = {
    languages.rust = {
      enable = mkEnableOption "Rust language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.rust_analyzer = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
      installCargo = mkDefault cfg.bundleTooling;
      installRustc = mkDefault cfg.bundleTooling;
    };
  };
}

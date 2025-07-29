{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.rust;
in
with lib;
{
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
    plugins.conform-nvim.settings.formatters_by_ft.rust = [
      (if cfg.bundleTooling then "${pkgs.rustfmt}/bin/rustmft" else "rustfmt")
    ];
  };
}

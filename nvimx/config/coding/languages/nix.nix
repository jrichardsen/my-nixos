{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.nix;
in
with lib;
{
  options = {
    languages.nix = {
      enable = mkEnableOption "Nix language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.nil_ls = {
      enable = true;
      package = mkIf (!cfg.bundleTooling) (mkDefault null);
    };
    plugins.conform-nvim.settings.formatters_by_ft.nix = [
      (if cfg.bundleTooling then "${pkgs.nixfmt-rfc-style}/bin/nixfmt" else "nixfmt")
    ];
  };
}

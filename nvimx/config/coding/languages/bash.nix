{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.bash;
in
with lib;
{
  options = {
    languages.bash = {
      enable = mkEnableOption "C/C++ language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config =
    mkIf cfg.enable {
      plugins.lsp.servers.bashls = {
        enable = true;
        package = mkIf (!cfg.bundleTooling) (mkDefault null);
      };
      plugins.conform-nvim.settings.formatters_by_ft.sh = [ (if cfg.bundleTooling then "${pkgs.shfmt}/bin/shfmt" else "shfmt") ];
    };
}

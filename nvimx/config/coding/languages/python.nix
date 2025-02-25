{
  lib,
  config,
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
  };
}

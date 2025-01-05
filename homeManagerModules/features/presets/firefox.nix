{ lib, config, ... }:
let
  cfg = config.features.presets.firefox;
in
with lib;
{
  options = {
    features.presets.firefox = {
      enable = mkEnableOption "firefox presets";
    };
  };

  config = mkIf cfg.enable {
    systemInterface.applications.webBrowser = mkIf config.programs.firefox.enable "firefox";
  };
}

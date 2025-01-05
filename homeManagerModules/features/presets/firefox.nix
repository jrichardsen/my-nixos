{ lib, config, ... }:
let
  cfg = config.features.presets.firefox;
  programCfg = config.programs.firefox;
in
with lib;
{
  options = {
    features.presets.firefox = {
      enable = mkEnableOption "firefox presets";
    };
  };

  config = mkIf cfg.enable {
    systemInterface.applications.webBrowser = mkIf programCfg.enable "${programCfg.package}/bin/firefox";
  };
}

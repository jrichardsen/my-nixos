{ lib, config, ... }:
let
  cfg = config.features.presets.flameshot;
  serviceCfg = config.services.flameshot;
in
with lib;
{
  options = {
    features.presets.flameshot = {
      enable = mkEnableOption "flameshot presets";
    };
  };

  config = mkIf cfg.enable {
    systemInterface.applications.screenshotTool = mkIf serviceCfg.enable "flameshot gui";
  };
}

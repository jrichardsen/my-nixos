{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.hardware.brightness;
in
with lib;
{
  options = {
    features.hardware.brightness = {
      enable = mkOption {
        type = types.bool;
        description = ''
          If enabled, installs utilities to control brightness.
        '';
      };
    };
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = [ pkgs.brightnessctl ]; 

    systemInterface.hardware.brightness = {
      increaseBrightness = "brightnessctl +5%";
      decreaseBrightness = "brightnessctl 5%-";
    };
  };
}

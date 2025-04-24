{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.hardware.backlight;
in
with lib;
{
  options = {
    features.hardware.backlight = {
      enable = mkOption {
        type = types.bool;
        description = ''
          If enabled, installs utilities to control backlight brightness.
        '';
      };
    };
  };

  config = mkIf cfg.enable { 
    environment.systemPackages = [ pkgs.brightnessctl ]; 

    systemInterface.hardware.backlight = {
      increaseBrightness = "brightnessctl set +5%";
      decreaseBrightness = "brightnessctl set 5%-";
    };
  };
}

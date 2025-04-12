{ lib, config, ... }:
let
  cfg = config.features.presets.dunst;
in
with lib;
{
  options = {
    features.presets.dunst = {
      enable = mkEnableOption "dunst presets";
    };
  };

  config = mkIf cfg.enable {
    services.dunst = {
      settings = {
        global.corner_radius = 4;
      };
    };
  };
}

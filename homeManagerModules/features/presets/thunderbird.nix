{ lib, config, ... }:
let
  cfg = config.features.presets.thunderbird;
in
with lib;
{
  options = {
    features.presets.thunderbird = {
      enable = mkEnableOption "thunderbird presets";
    };
  };

  config = mkIf cfg.enable {
    programs.thunderbird.profiles = {};
  };
}

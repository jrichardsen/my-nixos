{ lib, config, ... }:
let
  cfg = config.features.presets.thunderbird;
  programCfg = config.programs.thunderbird;
in
with lib;
{
  options = {
    features.presets.thunderbird = {
      enable = mkEnableOption "thunderbird presets";
    };
  };

  config = mkIf cfg.enable {
    programs.thunderbird.profiles = { };
    systemInterface.applications.mailClient = mkIf programCfg.enable "${programCfg.package}/bin/thunderbird";
  };
}

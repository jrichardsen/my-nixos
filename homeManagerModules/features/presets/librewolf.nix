{ lib, config, ... }:
let
  cfg = config.features.presets.librewolf;
in
with lib;
{
  options = {
    features.presets.librewolf = {
      enable = mkEnableOption "librewolf presets";
    };
  };

  config = mkIf cfg.enable {
    stylix.targets.librewolf.profileNames = [ ];
    systemInterface.applications.webBrowser = mkIf config.programs.librewolf.enable "librewolf";
  };
}

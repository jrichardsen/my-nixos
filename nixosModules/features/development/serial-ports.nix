{ lib, config, ... }:
let
  cfg = config.features.development.serialPorts;
in
with lib;
{
  options = {
    features.development.serialPorts = {
      enable = mkEnableOption "access to serial ports";
    };
  };

  config = mkIf cfg.enable {
    features.development.groups = [ "dialout" ];
  };
}

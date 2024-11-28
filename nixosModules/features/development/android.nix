{ lib, config, ... }:
let
  cfg = config.features.development.android;
in
with lib;
{
  options = {
    features.development.android = {
      enable = mkEnableOption "support for android development";
    };
  };

  config = mkIf cfg.enable {
    programs.adb.enable = true;
    features.development.groups = [ "adbusers" ];
  };
}

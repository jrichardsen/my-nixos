{
  lib,
  config,
  pkgs,
  ...
}:
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
    environment.systemPackages = with pkgs; [ android-tools ];
    features.development.groups = [ "adbusers" ];
  };
}

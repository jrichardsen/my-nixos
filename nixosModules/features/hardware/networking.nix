{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.hardware.networking;
in
with lib;
{
  options = {
    features.hardware.networking = {
      enable = mkOption {
        type = types.bool;
        description = ''
          If enabled, installs utilities to control networking.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    features.development.groups = [ "networkmanager" ];

    environment.systemPackages = mkIf config.features.gui.enable [ pkgs.networkmanagerapplet ];
    systemInterface.applications.networkManager = mkIf config.features.gui.enable "nm-connection-editor";
  };
}

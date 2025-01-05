{ config, lib, ... }:
let
  cfg = config.features.hardware.bluetooth;
  guiFeature = config.features.gui;
in
with lib;
{
  options = {
    features.hardware.bluetooth = {
      enable = mkOption {
        type = types.bool;
        description = ''
          If enabled, bluetooth will be configured and, assuming a GUI is
          available, extra utilities will be installed.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth.enable = true;
    services.blueman.enable = mkDefault guiFeature.enable;
    systemInterface.applications.bluetoothManager = mkIf config.services.blueman.enable "blueman-manager";
  };
}

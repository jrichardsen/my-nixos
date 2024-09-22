{ config, lib, ... }:
let
  cfg = config.features.bluetooth;
in
with lib;
{
  options.features.bluetooth.enable = mkOption {
    type = types.bool;
    # NOTE: remove this default to force the configuration to specify whether
    # bluetooth is available
    default = true;
    description = ''
      If enabled, bluetooth will be configured and, assuming a GUI is
      available, extra utilities will be installed.
    '';
  };

  config = mkIf cfg.enable {
    # Bluetooth
    hardware.bluetooth.enable = true;
    # TODO: make this depend on whether a gui exists
    services.blueman.enable = mkDefault true;
  };
}

{ lib, config, ... }:
let
  cfg = config.features.presets.bootloader;
in
with lib;
{
  options = {
    features.presets.bootloader = {
      enable = mkEnableOption "bootloader preset";
    };
  };

  config = mkIf cfg.enable {
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}

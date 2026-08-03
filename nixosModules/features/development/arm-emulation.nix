{ lib, config, ... }:
let
  cfg = config.features.development.arm-emulation;
in
with lib;
{
  options = {
    features.development.arm-emulation = {
      enable = mkEnableOption "support for arm/aarch64 emulation";
    };
  };

  config = mkIf cfg.enable {
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    nix.settings.extra-platforms = [ "aarch64-linux" "arm-linux" ];
  };
}

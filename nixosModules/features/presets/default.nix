{ lib, config, ... }:
let
  cfg = config.features.presets;
in
with lib;
{
  imports = [
    ./bootloader.nix
    ./keymap.nix
    ./locales.nix
    ./nix-compat.nix
    ./shell.nix
  ];

  options = {
    features.presets = {
      enableAll = mkEnableOption "all presets by default";
    };
  };

  config = {
    features.presets = mkIf cfg.enableAll (mkDefault {
      bootloader.enable = true;
      keymap.enable = true;
      locales.enable = true;
      nixCompat.enable = true;
      shell.enable = true;
    });
  };
}

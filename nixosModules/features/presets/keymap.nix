{ lib, config, ... }:
let
  cfg = config.features.presets.keymap;
in
with lib;
{
  options = {
    features.presets.keymap = {
      enable = mkEnableOption "keymap preset";
    };
  };

  config = mkIf cfg.enable {
    services.xserver.xkb = {
      layout = "de";
      variant = "neo_qwertz";
    };
    console.useXkbConfig = true;
  };
}

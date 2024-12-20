{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.rofi;
in
with lib;
{
  options = {
    features.presets.rofi = {
      enable = mkEnableOption "rofi presets";
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      theme = ../../../programs/rofi/onedark.rasi;
      terminal = "${pkgs.kitty}/bin/kitty";
      extraConfig = {
        modes = "drun,run,window,combi";
        combi-modes = "window, drun, run";
        kb-custom-1 = "Alt+1,Super+d";
        kb-custom-2 = "Alt+2,Super+x";
        kb-custom-3 = "Alt+3,Super+Tab";
        kb-custom-4 = "Alt+4,Super+odiaeresis";
      };
    };
  };
}

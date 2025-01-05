{ lib, config, ... }:
let
  cfg = config.features.presets.kitty;
  programCfg = config.programs.kitty;
in
with lib;
{
  options = {
    features.presets.kitty = {
      enable = mkEnableOption "kitty presets";
    };
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      theme = "One Dark";
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11.0;
      };
      keybindings = {
        "ctrl+plus" = "increase_font_size";
        "ctrl+minus" = "decrease_font_size";
        "ctrl+shift+q" = "noop";
        "ctrl+shift+w" = "noop";
      };
    };
    systemInterface.applications.terminal = mkIf programCfg.enable "${programCfg.package}/bin/kitty";
  };
}

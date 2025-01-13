{ lib, config, ... }:
let
  cfg = config.features.presets.kitty;
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
      themeFile = "OneDark";
      keybindings = {
        "ctrl+plus" = "increase_font_size";
        "ctrl+minus" = "decrease_font_size";
        "ctrl+shift+q" = "noop";
        "ctrl+shift+w" = "noop";
      };
    };
    systemInterface.applications.terminal = mkIf config.programs.kitty.enable "kitty";
  };
}

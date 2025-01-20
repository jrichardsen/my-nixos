{ config, 
  lib, 
  pkgs, 
  ... 
}:
let
  cfg = config.features.gui;
in
with lib;
{
  options = {
    features.gui = {
      enable = mkEnableOption "graphical user interface";
    };
  };

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    services.greetd = let
      hyprlandConfig = pkgs.writeText "greetd-hyprland.conf" ''
        exec-once = ${getExe config.programs.regreet.package}; hyprctl dispatch exit
        misc {
            disable_hyprland_logo = true
            disable_splash_rendering = true
            disable_hyprland_qtutils_check = true
        }
      '';
    in {
      enable = true;
      settings = {
        default_session.command = "Hyprland --config ${hyprlandConfig}";
      };
    };

    programs.regreet.enable = true;
  };
}

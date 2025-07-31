{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.desktopEnvironment;
in
with lib;
{
  options = {
    features.desktopEnvironment = {
      enable = mkEnableOption "custom desktop environment (i3/rofi/i3status-rust)";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;
    programs = {
      # To create ${HOME}/.profile
      bash.enable = true;

      waybar = {
        enable = true;
        systemd.enable = true;
      };

      rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
      };

      hyprlock.enable = true;
    };

    services.dunst.enable = true;

    systemInterface.applications.screenLocker = "loginctl lock-session";
    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = config.systemInterface.applications.screenLocker;
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };
        listener = [
          {
            timeout = 300;
            on-timeout = config.systemInterface.applications.screenLocker;
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    features.presets = mkDefault {
      hyprland.enable = true;
      waybar.enable = true;
      rofi = {
        enable = true;
        uwsm = true;
      };
    };

    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
        defaultApplications =
          let
            browserDesktop = "${config.systemInterface.applications.webBrowser}.desktop";
          in
          {
            "text/html" = browserDesktop;
            "x-scheme-handler/http" = browserDesktop;
            "x-scheme-handler/https" = browserDesktop;
            "x-scheme-handler/about" = browserDesktop;
            "x-scheme-handler/unknown" = browserDesktop;
          };
      };
      userDirs.enable = true;
    };

    home.packages = with pkgs; [
      wl-clipboard
    ];
  };
}

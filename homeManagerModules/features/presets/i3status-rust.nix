{ lib, config, ... }:
let
  cfg = config.features.presets.i3status-rust;
in
with lib;
{
  options = {
    features.presets.i3status-rust = {
      enable = mkEnableOption "i3status-rust presets";
    };
  };

  config = mkIf cfg.enable {
    programs.i3status-rust = {
      bars = {
        default = {
          settings = {
            theme = {
              theme = "solarized-dark";
              overrides = {
                idle_bg = "#282c34";
                idle_fg = "#abb2bf";
                info_bg = "#61afef";
                info_fg = "#282c34";
                warning_bg = "#e5c07b";
                warning_fg = "#282c34";
                critical_bg = "#e86671";
                critical_fg = "#282c34";
                good_bg = "#98c379";
                good_fg = "#282c34";
              };
            };
            icons_format = "{icon}";
          };
          icons = "awesome4";
          theme = "solarized-dark";
          blocks = [
            { block = "cpu"; }
            {
              block = "memory";
              format = " $icon $mem_used_percents.eng(w:2) ";
            }
            {
              block = "disk_space";
              path = "/";
              info_type = "available";
              format = " $icon $available.eng(w:2) ";
            }
            {
              block = "sound";
              headphones_indicator = true;
              click = [
                {
                  button = "left";
                  cmd = "pavucontrol";
                }
              ];
            }
            {
              block = "net";
              device = "enp9s0";
              format = " $icon {$ip|N/A} ";
            }
            {
              block = "time";
              interval = 5;
              format = " $timestamp.datetime(f:'%a %d.%m %R') ";
            }
          ];
        };
      };
    };
  };
}

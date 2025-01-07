{ lib, config, ... }:
let
  cfg = config.features.presets.i3status-rust;
  inherit (config.systemInterface.applications) audioManager;
  inherit (config.systemInterface.applications) bluetoothManager;
in
with lib;
{
  options = {
    features.presets.i3status-rust = {
      enable = mkEnableOption "i3status-rust presets";
      backlight = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "backlight device";
      };
      bluetoothHeadset = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "mac address of bluetooth headset";
      };
      ethernetInterface = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "ethernet interface to display";
      };
      wifiInterface = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "wifi interface to display";
      };
      battery = mkEnableOption "display of battery charge";
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
          blocks = mkMerge [
            [
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
            ]
            (optional (cfg.backlight != null) {
              block = "backlight";
              device = cfg.backlight;
              invert_icons = true;
            })
            [
              {
                block = "sound";
                headphones_indicator = true;
                click = optional (audioManager != null) ({
                  button = "left";
                  cmd = audioManager;
                });
              }
            ]
            (optional (cfg.bluetoothHeadset != null) {
              block = "bluetooth";
              mac = cfg.bluetoothHeadset;
              click = optional (bluetoothManager != null) ({
                button = "left";
                cmd = bluetoothManager;
              });
            })
            (optional (cfg.ethernetInterface != null) {
              block = "net";
              device = cfg.ethernetInterface;
              format = " $icon {$ip|N/A} ";
            })
            (optional (cfg.wifiInterface != null) {
              block = "net";
              device = cfg.wifiInterface;
              format = " $icon $ssid{ ($signal_strength)|}: {$ip|N/A} ";
            })
            (optional cfg.battery {
              block = "battery";
              format = " $icon $percentage ";
            })
            [
              {
                block = "time";
                interval = 5;
                format = " $timestamp.datetime(f:'%a %d.%m %R') ";
              }
            ]
          ];
        };
      };
    };
    systemInterface.applications.statusBarCommand = mkIf config.programs.i3status-rust.enable "i3status-rs ~/.config/i3status-rust/config-default.toml";
  };
}

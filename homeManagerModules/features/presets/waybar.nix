{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.presets.waybar;
in
{
  options = {
    features.presets.waybar = {
      enable = mkEnableOption "waybar presets";
    };
  };

  config = mkIf cfg.enable {
    programs.waybar = {
      settings = {
        mainBar = {
          spacing = 8;
          modules-left = [
            "hyprland/workspaces"
            "hyprland/submap"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "idle_inhibitor"
            "pulseaudio"
            "pulseaudio#source"
            "backlight"
            "cpu"
            "memory"
            "disk"
            "bluetooth"
            "network"
            "battery"
            "clock"
            "group/tray"
            "custom/power"
          ];
          "hyprland/workspaces" = {
            show-special = true;
            special-visible-only = true;
          };
          "hyprland/window" = {
            separate-outputs = true;
            max-length = 50;
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };
          pulseaudio = {
            format = "{volume}% {icon}";
            format-muted = " ";
            format-bluetooth = "{volume}% {icon}";
            format-icons = {
              headphone = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [
                " "
                " "
                " "
              ];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
            on-click-right = "pavucontrol";
          };
          "pulseaudio#source" = {
            format = "{format_source}";
            format-source = "{volume}%  ";
            format-source-muted = " ";
            on-click = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            on-click-right = "pavucontrol";
          };
          backlight = {
            format = "{percent}% {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
              " "
              " "
              " "
              " "
            ];
          };
          cpu = {
            format = "{usage}%  ";
            tooltip = false;
          };
          memory = {
            format = "{}%  ";
            tooltip-format = "Memory: {used:0.1f}/{total:0.1f} Gi  │  Swap: {swapUsed:0.1f}/{swapTotal:0.1f} Gi";
          };
          disk = {
            interval = 10;
            format = "{free}  ";
          };
          battery = {
            format = "{capacity}% {icon}";
            format-full = "";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}%  ";
            format-tooltip = "{time} {icon}";
            format-icons = [
              " "
              " "
              " "
              " "
              " "
            ];
          };
          bluetooth = {
            format = "<span style=\"italic\">{status}</span>  ";
            format-on = " ";
            format-connected = "{device_alias:.10s}  ";
            format-connected-battery = "{device_alias:.10s} ({device_battery_percentage}%)  ";
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
            on-click-right = "blueman-manager";
          };
          network = {
            format-wifi = "{essid} ({signalStrength}%)  ";
            format-ethernet = "{ipaddr}/{cidr}  ";
            tooltip-format = "{ifname}: {ipaddr}/{cidr} via {gwaddr}";
            format-linked = "{ifname} (No IP) 󰊗 ";
            format-disconnected = "Disconnected  ";
            format-alt = "{ifname}: {bandwidthUpBytes}   {bandwidthDownBytes}  ";
            on-click-right = "nm-connection-editor";
          };
          clock = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%Y-%m-%d}";
          };
          "group/tray" = {
            orientation = "inherit";
            drawer = {
              transition-left-to-right = false;
            };
            modules = [
              "custom/tray-icon"
              "tray"
            ];
          };
          "custom/tray-icon" = {
            format = "  ";
            tooltip = false;
          };
          tray = {
            icon-size = 16;
            spacing = 4;
          };
          "custom/power" = {
            format = " ";
            tooltip = false;
            menu = "on-click";
            menu-file = pkgs.writeText "power-menu.xml" ''
              <?xml version="1.0" encoding="UTF-8"?>
              <interface>
                <object class="GtkMenu" id="menu">
                  <child>
                  <object class="GtkMenuItem" id="suspend">
                    <property name="label">Suspend</property>
                      </object>
                </child>
                <child>
                      <object class="GtkMenuItem" id="hibernate">
                    <property name="label">Hibernate</property>
                      </object>
                </child>
                  <child>
                      <object class="GtkMenuItem" id="poweroff">
                    <property name="label">Poweroff</property>
                      </object>
                  </child>
                  <child>
                    <object class="GtkSeparatorMenuItem" id="delimiter1"/>
                  </child>
                  <child>
                  <object class="GtkMenuItem" id="reboot">
                    <property name="label">Reboot</property>
                  </object>
                  </child>
                </object>
              </interface>
            '';
            menu-actions = {
              poweroff = "shutdown now";
              reboot = "reboot";
              suspend = "systemctl suspend";
              hibernate = "systemctl hibernate";
            };
          };
        };
      };
    };
  };
}

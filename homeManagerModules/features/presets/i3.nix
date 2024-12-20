{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.i3;
in
with lib;
{
  options = {
    features.presets.i3 = {
      enable = mkEnableOption "i3 presets";
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3 = {
      config =
        let
          modifier = "Mod4";
          refresh_i3status = "killall -SIGUSR1 i3status";
        in
        {
          modifier = modifier;
          fonts = {
            names = [ "JetBrainsMono" ];
            style = "NerdFont";
            size = 12.0;
          };
          defaultWorkspace = "workspace number 1";
          floating.modifier = modifier;
          terminal = "kitty";
          startup = [
            {
              command = "${pkgs.lightlocker}/bin/light-locker";
              always = true;
              notification = false;
            }
            {
              command = "${pkgs.autorandr}/bin/autorandr --change";
              always = true;
              notification = false;
            }
          ];
          keybindings = pkgs.lib.mkOptionDefault {
            "${modifier}+Shift+Return" = "exec firefox";
            "${modifier}+m" = "exec thunderbird";
            Print = "exec \"flameshot gui\"";
            "${modifier}+d" = "exec \"rofi -show drun\"";
            "${modifier}+x" = "exec \"rofi -show run\"";
            "${modifier}+Tab" = "exec \"rofi -show window\"";
            "${modifier}+odiaeresis" = "exec \"rofi -show combi\"";
            "${modifier}+Shift+P" = "exec --no-startup-id \"rofi-power\"";
            XF86PowerOff = "exec --no-startup-id \"rofi-power\"";
            "${modifier}+h" = "focus left";
            "${modifier}+j" = "focus down";
            "${modifier}+k" = "focus up";
            "${modifier}+l" = "focus right";
            "${modifier}+Shift+h" = "move left";
            "${modifier}+Shift+j" = "move down";
            "${modifier}+Shift+k" = "move up";
            "${modifier}+Shift+l" = "move right";
            "${modifier}+Ctrl+h" = "move workspace to output left";
            "${modifier}+Ctrl+j" = "move workspace to output down";
            "${modifier}+Ctrl+k" = "move workspace to output up";
            "${modifier}+Ctrl+l" = "move workspace to output right";
            "${modifier}+b" = "split h";
            "${modifier}+y" = "focus child";
            "${modifier}+u" = "workspace number 1";
            "${modifier}+i" = "workspace number 2";
            "${modifier}+o" = "workspace number 3";
            "${modifier}+Shift+u" = "move container to workspace number 1";
            "${modifier}+Shift+i" = "move container to workspace number 2";
            "${modifier}+Shift+o" = "move container to workspace number 3";
            XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && ${refresh_i3status}";
            XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && ${refresh_i3status}";
            XF86AudioMute = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refresh_i3status}";
            XF86AudioMicMute = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";
            XF86MonBrightnessUp = "exec --no-startup-id brightnessctl set +5% && ${refresh_i3status}";
            XF86MonBrightnessDown = "exec --no-startup-id brightnessctl set 5%- && ${refresh_i3status}";
          };

          modes = {
            resize = {
              h = "resize shrink width 5 px or 5 ppt";
              j = "resize grow height 5 px or 5 ppt";
              k = "resize shrink height 5 px or 5 ppt";
              l = "resize grow width 5 px or 5 ppt";
              Left = "resize shrink width 5 px or 5 ppt";
              Down = "resize grow height 5 px or 5 ppt";
              Up = "resize shrink height 5 px or 5 ppt";
              Right = "resize grow width 5 px or 5 ppt";
              Return = "mode default";
              Escape = "mode default";
              "${modifier}+r" = "mode default";
            };
          };
          window = {
            titlebar = false;
            border = 3;
            hideEdgeBorders = "smart";
          };
          focus = {
            newWindow = "none";
          };
          bars = [
            {
              fonts = {
                names = [ "JetBrainsMono" ];
                style = "NerdFont";
                size = 12.0;
              };
              position = "bottom";
              statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
              trayOutput = "none";
              colors = {
                separator = "#666666";
                background = "#222222";
                statusline = "#dddddd";
                focusedWorkspace = {
                  background = "#0088CC";
                  border = "#0088CC";
                  text = "#FFFFFF";
                };
                activeWorkspace = {
                  background = "#333333";
                  border = "#333333";
                  text = "#FFFFFF";
                };
                inactiveWorkspace = {
                  background = "#333333";
                  border = "#333333";
                  text = "#888888";
                };
                urgentWorkspace = {
                  background = "#2F343A";
                  border = "#900000";
                  text = "#FFFFFF";
                };
              };
            }
          ];
        };
      extraConfig = ''
        no_focus [class="Zathura"]
      '';
    };
  };
}

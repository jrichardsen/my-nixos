{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.presets.i3;
in
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
          inherit (config.systemInterface.applications) terminal;
          startup =
            let
              mkStartup = command: {
                inherit command;
                always = true;
                notification = false;
              };
            in
            map mkStartup config.systemInterface.startupCommands;
          # NOTE: when do we want --no-startup-id
          keybindings =
            let
              apps = config.systemInterface.applications;
              mkAppKeybind = app: mkIf (app != null) "exec ${app}";
              mkCmdKeybind = cmd: mkIf (cmd != null) "exec --no-startup-id ${cmd} && ${refresh_i3status}";
              audioCmds = config.systemInterface.hardware.audio;
              brightnessCmds = config.systemInterface.hardware.brightness;
              mkIfRofi = mkIf (config.programs.rofi.enable && config.features.presets.rofi.enable);
              rofiPower = mkIf config.features.presets.rofi.rofi-power "exec --no-startup-id rofi-power";
            in
            mkOptionDefault {
              "${modifier}+Shift+Return" = mkAppKeybind apps.webBrowser;
              "${modifier}+m" = mkAppKeybind apps.mailClient;
              "Print" = mkAppKeybind apps.screenshotTool;
              "${modifier}+d" = mkIfRofi "exec rofi -show drun";
              "${modifier}+x" = mkIfRofi "exec rofi -show run";
              "${modifier}+Tab" = mkIfRofi "exec rofi -show window";
              "${modifier}+odiaeresis" = mkIfRofi "exec rofi -show combi";
              "${modifier}+Shift+P" = mkIfRofi rofiPower;
              XF86PowerOff = mkIfRofi rofiPower;
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
              XF86AudioRaiseVolume = mkCmdKeybind audioCmds.increaseVolume;
              XF86AudioLowerVolume = mkCmdKeybind audioCmds.decreaseVolume;
              XF86AudioMute = mkCmdKeybind audioCmds.toggleMute;
              XF86AudioMicMute = mkCmdKeybind audioCmds.toggleMicrophone;
              XF86MonBrightnessUp = mkCmdKeybind brightnessCmds.increaseBrightness;
              XF86MonBrightnessDown = mkCmdKeybind brightnessCmds.decreaseBrightness;
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

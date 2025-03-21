{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.presets.hyprland;
  apps = config.systemInterface.applications;
  hardware = config.systemInterface.hardware;
in
{
  options = {
    features.presets.hyprland = {
      enable = mkEnableOption "hyprland presets";
    };
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      # TODO: move this to desktop-environment.nix
      enable = true;

      plugins = with pkgs.hyprlandPlugins; [ hy3 ];

      extraConfig = "source = ~/.hyprland-dynamic.conf";

      settings =
        let
          mkCmdKeybind = keybind: cmd: mkIf (cmd != null) "${keybind}, exec, ${cmd}";
        in
        {
          "$mod" = "SUPER";

          # TODO: monitor aliases using variables
          monitor = [ ",preferred,auto,auto" ];

          general = {
            gaps_in = 4;
            gaps_out = 8;

            border_size = 2;

            resize_on_border = false;

            allow_tearing = false;

            layout = "hy3";
          };

          decoration = {
            rounding = 4;

            active_opacity = 1.0;
            inactive_opacity = 0.95;

            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
            };

            blur = {
              enabled = true;
              size = 3;
              passes = 1;

              vibrancy = 0.1696;
            };
          };
          animations = {
            enabled = "yes";

            bezier = [
              "easeOutQuint,0.23,1,0.32,1"
              "easeInOutCubic,0.65,0.05,0.36,1"
              "linear,0,0,1,1"
              "almostLinear,0.5,0.5,0.75,1.0"
              "quick,0.15,0,0.1,1"
            ];

            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade"
            ];
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
          };

          input = {
            kb_layout = "de,de";
            kb_variant = "neo_qwertz,";

            follow_mouse = 1;

            sensitivity = 0;

            touchpad = {
              natural_scroll = true;
            };
          };

          bind = [
            # General
            "$mod SHIFT, Q, hy3:killactive"
            "$mod SHIFT CTRL, Q, exec, uwsm stop"
            "$mod, C, hy3:makegroup, h, ephemeral"
            "$mod, V, hy3:makegroup, v, ephemeral"
            "$mod, G, hy3:makegroup, tab, ephemeral"
            "$mod SHIFT, C, hy3:changegroup, h"
            "$mod SHIFT, V, hy3:changegroup, v"
            "$mod SHIFT, G, hy3:changegroup, tab"
            "$mod, F, fullscreen, 1"
            "$mod SHIFT, F, fullscreen, 0"
            "$mod, A, hy3:changefocus, raise"
            "$mod, Y, hy3:changefocus, lower"

            # Programs
            (mkCmdKeybind "$mod, Return" apps.terminal)
            (mkCmdKeybind "$mod SHIFT, Return" apps.webBrowser)
            (mkCmdKeybind "$mod, M" apps.mailClient)

            # Move focus
            "$mod, H, hy3:movefocus, left, visible"
            "$mod, J, hy3:movefocus, down, visible"
            "$mod, K, hy3:movefocus, up, visible"
            "$mod, L, hy3:movefocus, right, visible"
            "$mod, Comma, hy3:focustab, left"
            "$mod, Period, hy3:focustab, right"
            "$mod, SPACE, hy3:togglefocuslayer"

            # Move window
            "$mod SHIFT, H, hy3:movefocus, left, once, visible"
            "$mod SHIFT, J, hy3:movefocus, down, once, visible"
            "$mod SHIFT, K, hy3:movefocus, up, once, visible"
            "$mod SHIFT, L, hy3:movefocus, right, once, visible"
            "$mod SHIFT, Comma, hy3:focustab, left"
            "$mod SHIFT, Period, hy3:focustab, right"
            "$mod SHIFT, SPACE, togglefloating"

            # Switch workspaces
            "$mod, U, workspace, 1"
            "$mod, I, workspace, 2"
            "$mod, O, workspace, 3"
            "$mod, 1, workspace, 1"
            "$mod, 2, workspace, 2"
            "$mod, 3, workspace, 3"
            "$mod, 4, workspace, 4"
            "$mod, 5, workspace, 5"
            "$mod, 6, workspace, 6"
            "$mod, 7, workspace, 7"
            "$mod, 8, workspace, 8"
            "$mod, 9, workspace, 9"
            "$mod, 0, workspace, 10"
            "$mod, S, toggleSpecialWorkspace, scratchpad"

            # Move active window to a workspace
            "$mod SHIFT, U, movetoworkspace, 1"
            "$mod SHIFT, I, movetoworkspace, 2"
            "$mod SHIFT, O, movetoworkspace, 3"
            "$mod SHIFT, 1, movetoworkspace, 1"
            "$mod SHIFT, 2, movetoworkspace, 2"
            "$mod SHIFT, 3, movetoworkspace, 3"
            "$mod SHIFT, 4, movetoworkspace, 4"
            "$mod SHIFT, 5, movetoworkspace, 5"
            "$mod SHIFT, 6, movetoworkspace, 6"
            "$mod SHIFT, 7, movetoworkspace, 7"
            "$mod SHIFT, 8, movetoworkspace, 8"
            "$mod SHIFT, 9, movetoworkspace, 9"
            "$mod SHIFT, 0, movetoworkspace, 10"
            "$mod SHIFT, S, movetoworkspace, special:scratchpad"

            # Move workspace on monitors
            "$mod CTRL, H, movecurrentworkspacetomonitor, l"
            "$mod CTRL, J, movecurrentworkspacetomonitor, d"
            "$mod CTRL, K, movecurrentworkspacetomonitor, u"
            "$mod CTRL, L, movecurrentworkspacetomonitor, r"
            "$mod SHIFT CTRL, H, swapactiveworkspaces, current l"
            "$mod SHIFT CTRL, J, swapactiveworkspaces, current d"
            "$mod SHIFT CTRL, K, swapactiveworkspaces, current u"
            "$mod SHIFT CTRL, L, swapactiveworkspaces, current r"
          ];

          bindel = [
            (mkCmdKeybind ", XF86AudioRaiseVolume" hardware.audio.increaseVolume)
            (mkCmdKeybind ", XF86AudioLowerVolume" hardware.audio.decreaseVolume)
            (mkCmdKeybind ", XF86AudioMute" hardware.audio.toggleMute)
            (mkCmdKeybind ", XF86AudioMicMute" hardware.audio.toggleMicrophone)
            (mkCmdKeybind ", XF86MonBrightnessUp" hardware.backlight.increaseBrightness)
            (mkCmdKeybind ", XF86MonBrightnessDown" hardware.backlight.decreaseBrightness)
          ];

          bindn = ", mouse:272, hy3:focustab, mouse";

          windowrulev2 = [
            # Ignore maximize requests from apps. You'll probably like this.
            "suppressevent maximize, class:.*"
            # Fix some dragging issues with XWayland
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          ];

          # TODO: stylix target for hy3
          plugin = {
            hy3 = {
              node_collapse_policy = 0;
              no_gaps_when_only = 1;

              tabs = {
                height = 24;
                text_height = 12;
                padding = 8;
                render_text = true;
              };
            };
          };

          exec-once = config.systemInterface.startupCommands;
        };

    };
  };
}

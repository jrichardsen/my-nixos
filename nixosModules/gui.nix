{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.gui;
in
with lib;
{
  options.features.gui.enable = mkOption {
    type = types.bool;
    # NOTE: remove this default to force the configuration to specify whether
    # a gui should be available
    default = true;
    description = ''
      If enabled, provided a graphical user interface.
    '';
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      desktopManager.xterm.enable = false;
      displayManager.lightdm.enable = true;
      windowManager.i3.enable = true;
    };
    services.picom.enable = true;
    services.udev.packages = [ pkgs.autorandr ];
    systemd.packages = [ pkgs.autorandr ];

    # TODO: split up
    environment.systemPackages = [ pkgs.autorandr pkgs.lightlocker ];

    # TODO: move this to its own module
    # Locker
    programs.xss-lock = {
      enable = true;
      lockerCommand = "light-locker-command --lock";
    };
  };
}

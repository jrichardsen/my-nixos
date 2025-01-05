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
  options = {
    features.gui = {
      enable = mkEnableOption "graphical user interface";
    };
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

    # NOTE: split up
    environment.systemPackages = [
      pkgs.autorandr
      pkgs.lightlocker
    ];

    # NOTE: move this to its own module
    # Locker
    programs.xss-lock = {
      enable = true;
      lockerCommand = config.systemInterface.applications.screenLocker;
    };

    systemInterface.applications.screenLocker = "light-locker-command --lock";

    systemInterface.startupCommands = [
      "light-locker-command"
      "autorandr --change"
    ];
  };
}

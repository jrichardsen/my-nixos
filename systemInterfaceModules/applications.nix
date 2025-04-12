{ lib, ... }:
with lib;
{
  options = {
    applications =
      let
        mkApplicationOption =
          description:
          mkOption {
            type = types.nullOr types.str;
            default = null;
            inherit description;
          };
      in
      {
        terminal = mkApplicationOption "Terminal application";
        webBrowser = mkApplicationOption "Web browser application";
        mailClient = mkApplicationOption "Mail client application";

        audioManager = mkApplicationOption "Audio manager application";
        bluetoothManager = mkApplicationOption "Bluetooth manager application";
        networkManager = mkApplicationOption "Network manager application";

        appLauncher = mkApplicationOption "Application launcher application";
        screenLocker = mkApplicationOption "Screen locker application";
        screenshotTool = mkApplicationOption "Screenshot tool";
        statusBarCommand = mkApplicationOption "Status bar command";
        powerMenu = mkApplicationOption "Power menu";
      };
  };
}

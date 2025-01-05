{ lib, ... }:
with lib;
{
  options = {
    # NOTE: work with desktop files (instead or additionally)
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

        screenLocker = mkApplicationOption "Screen locker application";
        screenshotTool = mkApplicationOption "Screenshot tool";
        statusBarCommand = mkApplicationOption "status bar command";
      };
  };
}

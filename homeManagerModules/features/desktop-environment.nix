{ lib, config, ... }:
let
  cfg = config.features.desktopEnvironment;
in
with lib;
{
  options = {
    features.desktopEnvironment = {
      enable = mkEnableOption "custom desktop environment (i3/rofi/i3status-rust)";
    };
  };

  config = mkIf cfg.enable {
    xsession.windowManager.i3.enable = true;
    programs = {
      i3status-rust.enable = true;
      rofi.enable = true;
    };

    features.presets = mkDefault {
      i3.enable = true;
      i3status-rust.enable = true;
      rofi.enable = true;
    };
  };
}

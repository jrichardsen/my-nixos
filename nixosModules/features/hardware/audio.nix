{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.features.hardware.audio;
in
with lib;
{
  options = {
    features.hardware.audio = {
      enable = mkOption {
        type = types.bool;
        description = "Whether to enable audio support";
      };
    };
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.systemPackages = [ pkgs.pavucontrol ];
  };
}

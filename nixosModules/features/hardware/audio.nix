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
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; mkMerge [
      [ pulseaudio ]
      (mkIf config.features.gui.enable [ pavucontrol ])
    ];
    systemInterface.applications.audioManager = mkIf config.features.gui.enable "pavucontrol";
    systemInterface.hardware.audio = {
      increaseVolume = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
      decreaseVolume = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
      toggleMute = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      toggleMicrophone = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
    };
  };
}

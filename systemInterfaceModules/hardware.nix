{ lib, ... }:
with lib;
{
  options = {
    hardware =
      let
        mkCommandOption =
          description:
          mkOption {
            type = types.nullOr types.str;
            default = null;
            inherit description;
          };
      in
      {
        audio = {
          increaseVolume = mkCommandOption "increase audio volume";
          decreaseVolume = mkCommandOption "decrease audio volume";
          toggleMute = mkCommandOption "toggle audio mute";
          toggleMicrophone = mkCommandOption "toggle microphone";
        };
        brightness = {
          increaseBrightness = mkCommandOption "increase screen brightness";
          decreaseBrightness = mkCommandOption "decrease screen brightness";
        };
      };
  };
}

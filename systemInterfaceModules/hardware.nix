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
        backlight = {
          increaseBrightness = mkCommandOption "increase backlight brightness";
          decreaseBrightness = mkCommandOption "decrease backlight brightness";
        };
      };
  };
}

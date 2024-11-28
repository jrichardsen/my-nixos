{
  config,
  lib,
  ...
}:
let
  cfg = config.features.hardware.touchpad;
in
with lib;
{
  options = {
    features.hardware.touchpad = {
      enable = mkOption {
        type = types.bool;
        description = ''
          Whether there is a touchpad.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.libinput.touchpad = {
      disableWhileTyping = true;
      naturalScrolling = true;
      additionalOptions = ''
        Option "PalmDetection" "True"
      '';
    };
  };
}

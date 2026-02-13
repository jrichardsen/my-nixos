{
  config,
  lib,
  ...
}:
let
  cfg = config.features.hardware.powerButton;
in
with lib;
{
  options = {
    features.hardware.powerButton = {
      enable = mkOption {
        type = types.bool;
        description = ''
          Whether there is a power button.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    # don't shutdown when power button is short-pressed
    services.logind.settings.Login = {
      HandlePowerKey = "ignore";
    };
  };
}

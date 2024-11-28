{
  config,
  lib,
  ...
}:
let
  cfg = config.features.hardware.printing;
in
with lib;
{
  options = {
    features.hardware.printing = {
      enable = mkOption {
        type = types.bool;
        description = ''
          Whether printing support should be enabled.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi.enable = true;
    services.avahi.nssmdns4 = true;
    services.avahi.openFirewall = true;
  };
}

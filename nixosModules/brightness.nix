{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.brightness;
in
with lib;
{
  options.features.brightness.enable = mkOption {
    type = types.bool;
    # NOTE: remove default
    default = false;
    description = ''
      If enabled, installs utilities to control brightness.
    '';
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [ pkgs.brightnessctl ];
  };
}

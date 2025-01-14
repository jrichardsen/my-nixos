{ lib, config, ... }:
let
  cfg = config.features.development.virtualbox;
in
with lib;
{
  options = {
    features.development.virtualbox = {
      enable = mkEnableOption "support for virtualbox development";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    features.development.groups = [ "vboxusers" ];
  };
}

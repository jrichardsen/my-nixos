{ lib, config, ... }:
let
  cfg = config.features.development.docker;
in
with lib;
{
  options = {
    features.development.docker = {
      enable = mkEnableOption "support for docker development";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    features.development.groups = [ "docker" ];
  };
}

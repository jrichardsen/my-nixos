{
  lib,
  config,
  ...
}:
let
  cfg = config.features.development;
in
with lib;
{
  imports = [
    ./android.nix
    ./docker.nix
    ./documentation.nix
    ./networking.nix
    ./serial-ports.nix
    ./virtualbox.nix
  ];

  options = {
    features.development = {
      users = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "devUser" ];
        description = ''
          Users that should have access to development features.
        '';
      };
      groups = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "dialout" ];
        description = ''
          Groups that development users should have access to.
        '';
      };
    };
    users.users = mkOption {
      type = types.attrsOf (
        types.submodule (
          { name, ... }:
          {
            config = mkIf (elem name cfg.users) {
              extraGroups = cfg.groups;
            };
          }
        )
      );
    };
  };
}

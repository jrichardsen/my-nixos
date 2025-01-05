{ lib, ... }:
with lib;
{
  options = {
    home-manager.users = mkOption { type = types.attrsOf (types.submodule ../homeManagerModules); };
    systemInterface = mkOption { type = types.submodule ../systemInterfaceModules; };
  };

  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}

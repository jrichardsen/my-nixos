{ lib, ... }:
with lib;
{
  options = {
    home-manager.users = mkOption {
      type = types.attrsOf (types.submoduleWith { modules = [ (import ../homeManagerModules) ]; });
    };
  };

  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
  };
}

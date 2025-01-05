{ lib, ... }:
with lib;
{
  imports = [
    ./applications.nix
    ./hardware.nix
  ];

  options = {
    startupCommands = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "commands to be executed on startup (of desktop environment)";
    };
  };
}

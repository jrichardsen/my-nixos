{ config, lib, pkgs, ... }:
let
  cfg = config.programs.discord;
in
with lib;
{
  options.programs.discord = {
    enable = mkEnableOption "Discord Desktop App";

    package = mkOption {
      type = types.package;
      default = pkgs.discord;
      defaultText = literalExpression "pkgs.discord";
      description = "Discord package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

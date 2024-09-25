{ config, lib, pkgs, ... }:
let
  cfg = config.programs.pympress;
in
with lib;
{
  options.programs.pympress = {
    enable = mkEnableOption "Pympress App";

    package = mkOption {
      type = types.package;
      default = pkgs.pympress;
      defaultText = literalExpression "pkgs.pympress";
      description = "Pympress package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

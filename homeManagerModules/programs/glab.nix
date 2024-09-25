{ config, lib, pkgs, ... }:
let
  cfg = config.programs.glab;
in
with lib;
{
  options.programs.glab = {
    enable = mkEnableOption "Gitlab CLI tool";

    package = mkOption {
      type = types.package;
      default = pkgs.glab;
      defaultText = literalExpression "pkgs.glab";
      description = "Package providing {command}`glab`.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

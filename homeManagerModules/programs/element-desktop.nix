{ config, lib, pkgs, ... }:
let
  cfg = config.programs.element-desktop;
in
with lib;
{
  options.programs.element-desktop = {
    enable = mkEnableOption "Element Desktop App";

    package = mkOption {
      type = types.package;
      default = pkgs.element-desktop;
      defaultText = literalExpression "pkgs.element-desktop";
      description = "Element Desktop package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

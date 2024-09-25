{ config, lib, pkgs, ... }:
let
  cfg = config.programs.signal-desktop;
in
with lib;
{
  options.programs.signal-desktop = {
    enable = mkEnableOption "Signal Desktop App";

    package = mkOption {
      type = types.package;
      default = pkgs.signal-desktop;
      defaultText = literalExpression "pkgs.signal-desktop";
      description = "Signal Desktop package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

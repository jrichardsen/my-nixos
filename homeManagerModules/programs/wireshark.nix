{ config, lib, pkgs, ... }:
let
  cfg = config.programs.wireshark;
in
with lib;
{
  options.programs.wireshark = {
    enable = mkEnableOption "Wireshark App";

    package = mkOption {
      type = types.package;
      default = pkgs.wireshark;
      defaultText = literalExpression "pkgs.wireshark";
      description = "Wireshark package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

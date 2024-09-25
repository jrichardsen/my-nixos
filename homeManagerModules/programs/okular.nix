{ config, lib, pkgs, ... }:
let
  cfg = config.programs.okular;
in
with lib;
{
  options.programs.okular = {
    enable = mkEnableOption "Okular App";

    package = mkOption {
      type = types.package;
      default = pkgs.okular;
      defaultText = literalExpression "pkgs.okular";
      description = "Okular package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

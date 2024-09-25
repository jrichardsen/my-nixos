{ config, lib, pkgs, ... }:
let
  cfg = config.programs.libreoffice;
in
with lib;
{
  options.programs.libreoffice = {
    enable = mkEnableOption "LibreOffice Suite";

    package = mkOption {
      type = types.package;
      default = pkgs.libreoffice;
      defaultText = literalExpression "pkgs.libreoffice";
      description = "LibreOffice package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

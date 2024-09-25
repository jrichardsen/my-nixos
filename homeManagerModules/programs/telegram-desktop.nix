{ config, lib, pkgs, ... }:
let
  cfg = config.programs.telegram-desktop;
in
with lib;
{
  options.programs.telegram-desktop = {
    enable = mkEnableOption "Telegram Desktop App";

    package = mkOption {
      type = types.package;
      default = pkgs.telegram-desktop;
      defaultText = literalExpression "pkgs.telegram-desktop";
      description = "Telegram Desktop package to install";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

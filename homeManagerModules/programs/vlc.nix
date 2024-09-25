{ config, lib, pkgs, ... }:
let
  cfg = config.programs.vlc;
in
with lib;
{
  options.programs.vlc = {
    enable = mkEnableOption "VLC App";

    package = mkOption {
      type = types.package;
      default = pkgs.vlc;
      defaultText = literalExpression "pkgs.vlc";
      description = "VLC package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

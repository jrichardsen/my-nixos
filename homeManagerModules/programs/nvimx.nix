{ config, lib, pkgs, ... }:
let
  cfg = config.programs.nvimx;
in
with lib;
{
  options.programs.nvimx = {
    enable = mkEnableOption "NvimX";

    package = mkOption {
      type = types.package;
      default = pkgs.nvimx;
      defaultText = literalExpression "pkgs.nvimx";
      description = "NvimX package to install.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}

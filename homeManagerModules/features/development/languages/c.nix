{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.c;
in
with lib;
{
  options = {
    features.development.languages.c = {
      enable = mkEnableOption "C(++) language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gcc
      bear

      # language server
      clang-tools
    ];

    programs.nixvim.languages.c.enable = true;
  };
}

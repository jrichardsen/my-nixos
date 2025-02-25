{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.python;
in
with lib;
{
  options = {
    features.development.languages.python = {
      enable = mkEnableOption "python language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      pyright
    ];

    programs.nixvim.languages.python.enable = true;
  };
}

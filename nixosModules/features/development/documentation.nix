{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.documentation;
in
with lib;
{
  options = {
    features.development.documentation = {
      enable = mkEnableOption "documentation for developers";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];

    documentation.dev.enable = true;
    documentation.man.generateCaches = true;
  };
}

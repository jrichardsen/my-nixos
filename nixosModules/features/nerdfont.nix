{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.nerdfont;
in
with lib;
{
  options = {
    features.nerdfont = {
      enable = mkEnableOption "nerdfont";
    };
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
      fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

}

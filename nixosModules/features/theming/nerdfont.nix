{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.features.theming.nerdfont;
in
with lib;
{
  options = {
    features.theming.nerdfont = {
      enable = mkEnableOption "nerdfont";
    };
  };

  config = mkIf cfg.enable {
    stylix.fonts.monospace = {
      package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
      name = "JetBrainsMono Nerd Font";
    };
    fonts = mkIf (!config.stylix.enable) {
      packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
      fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

}

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

  options.features.nerdfont.enable = mkOption {
    type = types.bool;
    default = true;
    description = ''
      If enabled, JetBrainsMono Nerd Font will be installed and used as the
      default monspace font.
    '';
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];
      fontconfig.defaultFonts.monospace = [ "JetBrainsMono Nerd Font" ];
    };
  };

}

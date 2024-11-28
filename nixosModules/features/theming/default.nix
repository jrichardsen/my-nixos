{ lib
  , config
  , ...
  }:
let
  cfg = config.features.theming;
in
  with lib;
{
  options = {
    features.theming = {
      enable = mkEnableOption "theming";
    };
  };

  config = mkIf cfg.enable {
    # FIXME: this does not seem to do anything, figure out theming properly
    # NOTE: try stylix
    environment.etc = {
      "xdg/gtk-2.0/gtkrc".text = "gtk-application-prefer-dark-theme=1";
      "xdg/gtk-3.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme = true
      '';
      "xdg/gtk-4.0/settings.ini".text = ''
        [Settings]
        gtk-application-prefer-dark-theme = true
      '';
    };

  };
}

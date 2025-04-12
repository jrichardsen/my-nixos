{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.features.gui;
in
with lib;
{
  options = {
    features.gui = {
      enable = mkEnableOption "graphical user interface";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
      };

      regreet = {
        enable = true;
        cageArgs = [
          "-s"
          "-m"
          "last"
        ];

        font.size = config.stylix.fonts.sizes.applications;
      };

      hyprlock.enable = true;
    };

    systemd.packages = [ pkgs.hyprpolkitagent ];
    # NOTE: should hopefully be fixed with nixos 25.05
    systemInterface.startupCommands = [ "systemctl --user start hyprpolkitagent" ];
  };
}

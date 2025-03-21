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
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    programs.regreet = {
      enable = true;
      cageArgs = [
        "-s"
        "-m"
        "last"
      ];
    };

    systemd.packages = [ pkgs.hyprpolkitagent ];
    # NOTE: should hopefully be fixed with nixos 25.05
    systemInterface.startupCommands = [ "systemctl --user start hyprpolkitagent" ];

    # adjustments for wayland
    nixpkgs.overlays = [
      (self: super: {
        flameshot = super.flameshot.override { enableWlrSupport = true; };
      })
    ];
  };
}

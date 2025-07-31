{ lib, config, ... }:
let
  cfg = config.features.presets.zathura;
  programCfg = config.programs.zathura;
in
with lib;
{
  options = {
    features.presets.zathura = {
      enable = mkEnableOption "zathura presets";
    };
  };

  config = mkIf cfg.enable {
    # force this to override stylix
    programs.zathura.options = mkForce {
      highlight-color = "rgba(255, 255, 255, 0)";
      highlight-active-color = "rgba(255, 255, 255, 0)";
    };

    xdg.mimeApps.defaultApplications = mkIf programCfg.enable {
      "application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
}

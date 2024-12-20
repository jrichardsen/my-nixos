{ lib, config, ...}:
let
  cfg = config.features.presets.zathura;
in
with lib;
{
  options = {
    features.presets.zathura = {
      enable = mkEnableOption "zathura presets";
    };
  };

  config = mkIf cfg.enable {
    programs.zathura.options = {
        highlight-color = "rgba(255, 255, 255, 0)";
        highlight-active-color = "rgba(255, 255, 255, 0)";
    };
  };
}

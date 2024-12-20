{ lib, config, ... }:
let
  cfg = config.features.presets.starship;
in
with lib;
{
  options = {
    features.presets.starship = {
      enable = mkEnableOption "starship presets";
    };
  };
  config = mkIf cfg.enable {
    programs.starship = {
      enableZshIntegration = config.programs.zsh.enable;
    };
  };
}

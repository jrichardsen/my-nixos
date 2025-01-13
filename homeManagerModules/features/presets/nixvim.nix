{ lib, config, ... }:
let
  cfg = config.features.presets.nixvim;
in
with lib;
{
  options = {
    features.presets.nixvim = {
      enable = mkEnableOption "nixvim presets";
    };
  };

  config = mkIf cfg.enable {
    programs.nixvim = {
      languages.enableByDefault = false;
    };

    stylix.targets.nixvim.enable = false;
  };
}

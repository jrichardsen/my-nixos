{ lib, config, ... }:
let
  cfg = config.features.presets.direnv;
in
with lib;
{
  options = {
    features.presets.direnv = {
      enable = mkEnableOption "direnv presets";
    };
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enableZshIntegration = config.programs.zsh.enable;
      nix-direnv.enable = true;
    };
  };
}

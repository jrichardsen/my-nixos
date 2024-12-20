{ lib, config, ... }:
let
  cfg = config.features.presets.git;
in
with lib;
{
  options = {
    features.presets.git = {
      enable = mkEnableOption "git presets";
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      userName = "jrichardsen";
      userEmail = "jonas.richardsen@gmail.com";
      extraConfig = {
        core = {
          autocrlf = "input";
          editor = "nvim";
        };
      };
      ignores = [
        ".direnv"
        ".envrc"
      ];
    };
  };
}

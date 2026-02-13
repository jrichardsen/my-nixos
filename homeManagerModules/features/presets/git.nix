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
      settings = {
        user.name = "jrichardsen";
        user.email = "jonas.richardsen@gmail.com";
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

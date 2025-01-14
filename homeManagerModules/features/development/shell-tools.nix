{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.shellTools;
in
with lib;
{
  options = {
    features.development.shellTools = {
      enable = mkEnableOption "shell tools";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      kitty.enable = true;

      direnv.enable = true;
      fzf.enable = true;
      gh.enable = true;
      git.enable = true;
      nixvim.enable = true;
      starship.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };

    home.packages = with pkgs; [
      glab

      gnumake

      ripgrep
      fd

      tree
    ];
  };
}

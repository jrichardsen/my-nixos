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

  # NOTE: reconsider gh and glab
  config = mkIf cfg.enable {
    programs = {
      kitty.enable = true;

      direnv.enable = true;
      git.enable = true;
      gh.enable = true;
      fzf.enable = true;
      starship.enable = true;
      tmux.enable = true;
      zsh.enable = true;
    };

    home.packages = with pkgs; [
      glab
      nvimx

      gnumake

      ripgrep
      fd

      tree
    ];
  };
}

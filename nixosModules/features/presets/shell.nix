{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.shell;
in
with lib;
{
  options = {
    features.presets.shell = {
      enable = mkEnableOption "shell presets";
    };
  };

  config = mkIf cfg.enable {
    # Enable shell system-wide
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;
    environment.shells = [ pkgs.zsh ];

    # Enable shell completion
    programs.zsh.enableCompletion = true;
    programs.zsh.enableBashCompletion = true;
    environment.pathsToLink = [ "/share/zsh" ];

    environment.systemPackages = with pkgs; [
      wget
      curl

      zip
      unzip

      vim

      xsel

      htop
    ];
  };
}

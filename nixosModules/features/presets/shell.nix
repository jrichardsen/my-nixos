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

    # TODO: minimize, move some to development and home-manager
    environment.systemPackages = with pkgs; [
      wget
      curl
      zip
      unzip
      git
      gnumake
      vim
      ripgrep
      fd
      fzf
      xsel
      tree
      dig
    ];
  };
}

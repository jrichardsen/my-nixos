{ pkgs, ... }:
{
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  programs = {
    home-manager.enable = true;

    firefox.enable = true;
    feh.enable = true;
    zathura.enable = true;

    thunderbird.enable = true;
  };

  home.packages = with pkgs; [
    libreoffice
    okular
    pympress
    vlc

    discord
    element-desktop
    signal-desktop
    telegram-desktop
  ];

  services = {
    dunst.enable = true;
    flameshot.enable = true;
  };

  features = {
    desktopEnvironment.enable = true;
    presets.enableAll = true;

    development = {
      networking.enable = true;
      languages = {
        c.enable = true;
        haskell.enable = true;
        latex.enable = true;
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
      };
      shellTools.enable = true;
    };
  };

  home.file.bin = {
    source = ../../programs/scripts;
    recursive = true;
  };

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.cargo/bin"
  ];

  home.stateVersion = "23.05";
}

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
    kdePackages.okular
    pympress
    vlc

    discord
    element-desktop
    signal-desktop
    telegram-desktop
  ];

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

  wayland.windowManager.hyprland.settings.monitor = [
    "desc:Samsung Electric Company LS27D80xU HK2XB01839, 3840x2160@60, 0x0, 1.5"
    "desc:BNQ BenQ GW2265 TAD00473019, 1920x1080@60, 2560x0, 1"
  ];

  home.stateVersion = "23.05";
}

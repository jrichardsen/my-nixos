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
    presets.i3status-rust = {
      backlight = "intel_backlight";
      bluetoothHeadset = "F4:4E:FD:00:1F:A6";
      ethernetInterface = "enp3s0";
      wifiInterface = "wlp2s0";
      battery = true;
    };

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

  home.stateVersion = "23.05";
}

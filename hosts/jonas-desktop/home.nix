{

  imports = [ ../../homeManagerModules ];

  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  programs = {
    direnv.enable = true;
    git.enable = true;
    gh.enable = true;
    glab.enable = true;
    fzf.enable = true;
    nvimx.enable = true;
    starship.enable = true;
    tmux.enable = true;
    zsh.enable = true;

    home-manager.enable = true;
    i3status-rust.enable = true;
    rofi.enable = true;

    kitty.enable = true;

    firefox.enable = true;
    feh.enable = true;
    zathura.enable = true;
    libreoffice.enable = true;
    okular.enable = true;
    pympress.enable = true;
    vlc.enable = true;
    wireshark.enable = true;

    # Messaging
    thunderbird.enable = true;
    element-desktop.enable = true;
    signal-desktop.enable = true;
    telegram-desktop.enable = true;
    discord.enable = true;
  };

  services = {
    dunst.enable = true;
    flameshot.enable = true;
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

# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "jonas-desktop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # don't shutdown when power button is short-pressed
  services.logind.extraConfig = ''
    HandlePowerKey = ignore
  '';
  programs.xss-lock = {
    enable = true;
    lockerCommand = "${pkgs.lightlocker}/bin/light-locker-command --lock";
  };

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  security.pki.certificateFiles = [ "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt" ./certs/geant.pem ];

  # Allow running unpatched dynamic binaries
  programs.nix-ld.enable = true;

  # nix options for derivations to persist garbage collection
  nix = {
    settings = {
      keep-outputs = true;
      keep-derivations = true;
      experimental-features = [ "nix-command" "flakes" ];
    };
  };
  environment.pathsToLink = [
    "/share/nix-direnv"
    "/share/zsh"
  ];

  # Pinning the registry to system pkgs
  nix.registry = {
    nixpkgs.to = {
      type = "path";
      path = pkgs.path;
    };
  };

  nixpkgs.config.allowUnfree = true;

  # Enable shell system-wide
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  # Fix for scripts with "#!/bin/bash"
  services.envfs.enable = true;

  # Install nerdfont
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Use i3 as window manager
  programs.dconf.enable = true;
  services.xserver = {
    enable = true;

    desktopManager.xterm.enable = false;

    displayManager.lightdm = {
      enable = true;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3status-rust
      ];
    };

    # Configure keymap in X11
    xkb = {
      layout = "de";
      variant = "neo_qwertz";
    };
  };

  services.libinput.touchpad = {
    disableWhileTyping = true;
    naturalScrolling = true;
    additionalOptions = ''
      Option "PalmDetection" "True"
    '';
  };

  services.picom.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "dialout" "docker" ];
  };

  documentation = {
    enable = true;
    man.enable = true;
    dev.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    curl
    zip
    unzip
    git
    gnumake
    vim
    stow
    ripgrep
    fd
    fzf
    rofi
    xsel
    tree
    man-pages
    man-pages-posix

    dig

    pulseaudio
    pavucontrol
    brightnessctl
    lightlocker
    autorandr

    python3
    nil
    nixpkgs-fmt
    clang-tools
    clang
    rustup
    opam
    cacert
    cabal-install
    ghc
    haskell-language-server 
    ormolu
    texlive.combined.scheme-full
  ];

  hardware.opengl.enable = true;

  environment.variables.EDITOR = "vim";

  # Enable android developement
  programs.adb.enable = true;

  # Enable docker
  virtualisation.docker.enable = true;

  services.udev.packages = [ pkgs.autorandr ];
  systemd.packages = [ pkgs.autorandr ];

  # Enable dark mode in gtk applications
  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = "gtk-application-prefer-dark-theme=1";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme = true
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-application-prefer-dark-theme = true
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

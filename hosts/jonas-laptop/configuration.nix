{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.jonas = import ./home.nix;

  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "wheel" ];
  };

  features = {
    development = {
      users = [ "jonas" ];
      android.enable = true;
      docker.enable = true;
      documentation.enable = true;
      networking.enable = true;
      serialPorts.enable = true;
    };
    gui.enable = true;
    hardware = {
      audio.enable = true;
      backlight.enable = true;
      bluetooth.enable = true;
      networking.enable = true;
      powerButton.enable = true;
      printing.enable = true;
      touchpad.enable = true;
    };
    nerdfont.enable = true;
    presets.enableAll = true;
    theming.enable = true;
  };

  system.stateVersion = "23.05";
}

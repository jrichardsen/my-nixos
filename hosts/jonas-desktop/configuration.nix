{
  imports = [
    ./hardware-configuration.nix
  ];

  home-manager.users.jonas = import ./home.nix;

  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [ "wheel" "input" ];
  };

  features = {
    development = {
      users = [ "jonas" ];
      android.enable = true;
      docker.enable = true;
      documentation.enable = true;
      networking.enable = true;
      serialPorts.enable = true;
      virtualbox.enable = true;
    };
    gui.enable = true;
    hardware = {
      audio.enable = true;
      bluetooth.enable = true;
      backlight.enable = false;
      networking.enable = true;
      powerButton.enable = true;
      printing.enable = true;
      touchpad.enable = false;
    };
    presets.enableAll = true;
    theming = {
      enable = true;
      nerdfont.enable = true;
    };
  };

  system.stateVersion = "23.05";
}

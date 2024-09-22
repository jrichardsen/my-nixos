{
  imports = [
    ./hardware-configuration.nix
    ../../nixosModules
  ];

  home-manager.users.jonas = import ./home.nix;

  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    # TODO: expose option to allow other modules to add groups for specific
    # types of users
    extraGroups = [
      "networkmanager"
      "wheel"
      "adbusers"
      "dialout"
      "docker"
    ];
  };

  system.stateVersion = "23.05";
}

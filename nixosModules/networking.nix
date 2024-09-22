{
  config = {
  networking.networkmanager.enable = true;

  # TODO: move to this to flake or pass the host into the configuration as an argument
  networking.hostName = "jonas-desktop"; # Define your hostname.
  };
}

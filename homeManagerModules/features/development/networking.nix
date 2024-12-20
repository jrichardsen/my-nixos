{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.networking;
in
with lib;
{
  options = {
    features.development.networking = {
      enable = mkEnableOption "networking tools";
    };
  };

  # NOTE: figure out wireshark
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      arp-scan
      dig
      nmap
    ];
  };
}

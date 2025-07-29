{
  lib,
  config,
  pkgs,
  osConfig ? { },
  ...
}:
let
  cfg = config.features.development.networking;
  hasWireshark = osConfig.programs.wireshark.enable or false;
in
with lib;
{
  options = {
    features.development.networking = {
      enable = mkEnableOption "networking tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      [
        arp-scan
        dig
        nmap
      ]
      ++ optional (!hasWireshark) wireshark;
  };
}

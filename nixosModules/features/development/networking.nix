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
      enable = mkEnableOption "support for networking development";
    };
  };

  # NOTE: arp-scan with privileges
  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
      package = if config.features.gui.enable then pkgs.wireshark-qt else pkgs.wireshark-cli;
    };
    features.development.groups = [ "wireshark" ];
  };
}

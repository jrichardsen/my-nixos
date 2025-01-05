{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.rust;
in
with lib;
{
  options = {
    features.development.languages.rust = {
      enable = mkEnableOption "rust language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rustup ];

    # NOTE: should this really be set?
    home.sessionPath = [ "$HOME/.cargo/bin" ];
  };
}

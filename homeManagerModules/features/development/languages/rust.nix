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

    home.sessionPath = [ "$HOME/.cargo/bin" ];

    programs.nixvim.languages.rust.enable = true;
  };
}

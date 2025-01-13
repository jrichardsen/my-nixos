{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.nix;
in
with lib;
{
  options = {
    features.development.languages.nix = {
      enable = mkEnableOption "nix language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixpkgs-fmt

      # language server
      nil
    ];

    programs.nixvim.languages.nix.enable = true;
  };
}

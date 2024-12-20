{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.haskell;
in
with lib;
{
  options = {
    features.development.languages.haskell = {
      enable = mkEnableOption "haskell language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      ghc
      ormolu
    ];
  };
}

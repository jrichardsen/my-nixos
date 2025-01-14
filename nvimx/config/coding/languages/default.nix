{ lib, config, ... }:
let
  cfg = config.languages;
in
with lib;
{
  imports = [
    ./c.nix
    ./haskell.nix
    ./latex.nix
    ./nix.nix
    ./rust.nix
  ];

  options = {
    languages = {
      enableByDefault = mkOption {
        type = types.bool;
        description = ''
          Enables support for all available languages by default.
          Can be overridden for individual languages by setting
          `languages.<language>.enable`.
        '';
        default = true;
      };
      bundleTooling = mkOption {
        type = types.bool;
        description = ''
          Whether tooling for languages (mostly language servers) should be included.
          Can be overridden for individual languages by setting
          `languages.<language>.bundleTooling`.
        '';
        default = false;
      };
    };
  };

  config = {
    languages = mkMerge [
      (mkIf cfg.enableByDefault (mkDefault {
        c.enable = true;
        haskell.enable = true;
        latex.enable = true;
        nix.enable = true;
        rust.enable = true;
      }))
      (mkIf cfg.bundleTooling (mkDefault {
        c.bundleTooling = true;
        haskell.bundleTooling = true;
        latex.bundleTooling = true;
        nix.bundleTooling = true;
        rust.bundleTooling = true;
      }))
    ];
  };
}

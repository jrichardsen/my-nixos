{ lib, config, pkgs, ... }:
let
  cfg = config.features.presets.nixCompat;
  in
  with lib;
{
  options = {
    features.presets.nixCompat = {
      enable = mkEnableOption "nix related presets";
    };
  };

  config = mkIf cfg.enable {
    # Allow installing unfree packages
    nixpkgs.config.allowUnfree = true;

    # Allow running unpatched dynamic binaries
    programs.nix-ld.enable = true;

    # Fix for scripts with "#!/bin/bash"
    services.envfs.enable = true;

    # Enable flakes
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # nix options for derivations to persist garbage collection
    nix.settings = {
      keep-outputs = true;
      keep-derivations = true;
    };

    # Pinning the registry to system pkgs
    nix.registry = {
      nixpkgs.to = {
        type = "path";
        path = pkgs.path;
      };
    };
  };

}

{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix/release-24.11";
    nixvim.url = "github:nix-community/nixvim/nixos-24.11";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      stylix,
      nixvim,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { withSystem, config, ... }:
      {
        flake = {
          overlays = {
            unstable-pkgs = final: prev: {
              unstable = import nixpkgs-unstable { inherit (prev.stdenv.hostPlatform) system; };
            };
            nvimx =
              final: prev:
              withSystem prev.stdenv.hostPlatform.system (
                { config, ... }:
                {
                  inherit (config.packages) nvimx;
                }
              );
          };

          nixosModules = {
            default = ./nixosModules;
            includeOverlays = {
              nixpkgs.overlays = builtins.attrValues config.flake.overlays;
            };
            systemModules = {
              imports = [
                config.flake.nixosModules.default
                config.flake.nixosModules.includeOverlays
                home-manager.nixosModules.home-manager
                stylix.nixosModules.stylix
              ];
            };
          };

          # TODO: figure out standalone home-manager
          nixosConfigurations =
            let
              mkNixosSystem =
                host: system:
                nixpkgs.lib.nixosSystem {
                  inherit system;
                  modules = [
                    ./hosts/${host}/configuration.nix
                    { networking.hostName = host; }
                    config.flake.nixosModules.systemModules
                  ];
                };
              hosts = {
                jonas-desktop = "x86_64-linux";
                jonas-laptop = "x86_64-linux";
              };
            in
            builtins.mapAttrs mkNixosSystem hosts;
        };

        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        perSystem =
          { pkgs, system, ... }:
          let
            nixvim' = nixvim.legacyPackages.${system};
            utils = import ./nvimx/utils;
            nixvimModule = {
              inherit pkgs;
              module = import ./nvimx/config;
              extraSpecialArgs = {
                inherit utils;
              };
            };
            nvimx = nixvim'.makeNixvimWithModule nixvimModule;
            nvimxWithTooling = nvimx.extend { languages.bundleTooling = true; };
            nvimxNoIcons = nvimx.extend { style.icons.enable = false; };
          in
          {
            packages = {
              inherit nvimx;
              inherit nvimxWithTooling;
              inherit nvimxNoIcons;
            };
          };
      }
    );
}

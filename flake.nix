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
        imports = [ flake-parts.flakeModules.modules ];

        flake = {
          overlays = {
            unstable-pkgs = final: prev: {
              unstable = import nixpkgs-unstable { inherit (prev.stdenv.hostPlatform) system; };
            };
          };

          modules = {
            nixos = {
              default = ./nixosModules;
              includeOverlays = {
                nixpkgs.overlays = builtins.attrValues config.flake.overlays;
              };
              homeManagerIntegration =
                { lib, ... }:
                with lib;
                {
                  imports = [ home-manager.nixosModules.home-manager ];

                  options = {
                    home-manager.users = mkOption {
                      type = types.attrsOf (types.submodule (builtins.attrValues config.flake.modules.homeManager));
                    };
                    systemInterface = mkOption { type = types.submodule config.flake.modules.generic.systemInterface; };
                  };
                };
              systemModules = {
                imports = with config.flake.modules.nixos; [
                  default
                  includeOverlays
                  homeManagerIntegration

                  stylix.nixosModules.stylix
                ];
              };
            };
            homeManager = {
              default = ./homeManagerModules;
              nixvimIntegration =
                { lib, ... }:
                with lib;
                {
                  imports = [ nixvim.homeManagerModules.nixvim ];
                  options.programs.nixvim = mkOption {
                    type = types.submoduleWith { modules = [ config.flake.modules.generic.nvimx ]; };
                  };
                };
              systemIntegration =
                { lib, ... }:
                with lib;
                {
                  options.systemInterface = mkOption {
                    type = types.submodule config.flake.modules.generic.systemInterface;
                  };
                };
            };
            generic = {
              systemInterface = ./systemInterfaceModules;
              nvimx = {
                imports = [ ./nvimx/config ];
                _module.args.utils = import ./nvimx/utils;
              };
            };
          };

          nixosModules = config.flake.modules.nixos;

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

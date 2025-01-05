{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # NOTE: revisit nvimx integration
    nvimx.url = "github:jrichardsen/nvimx";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nvimx,
      ...
    }:
    {
      overlays = {
        add-unstable-pkgs = final: _prev: {
          unstable = import nixpkgs-unstable { inherit (final) system; };
        };
        add-nvimx = final: _prev: { nvimx = nvimx.packages.${final.system}.nvimx; };
      };

      nixosModules = {
        default = ./nixosModules;
        externalDependencyOverlays = {
          nixpkgs.overlays = builtins.attrValues self.overlays;
        };
        systemModules = {
          imports = [
            self.nixosModules.default
            self.nixosModules.externalDependencyOverlays
            home-manager.nixosModules.home-manager
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
                self.nixosModules.systemModules
              ];
            };
          hosts = {
            jonas-desktop = "x86_64-linux";
          };
        in
        builtins.mapAttrs mkNixosSystem hosts;
    };
}

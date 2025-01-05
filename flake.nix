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
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nvimx,
      ...
    }:
    {
      # TODO: provide/expose a function that allows to build a system
      nixosConfigurations =
        let
          add-unstable-pkgs = system: final: _prev: {
            unstable = import nixpkgs-unstable { inherit system; };
          };
          add-nvimx = system: final: _prev: { nvimx = nvimx.packages.${system}.nvimx; };
          externalDependencyOverlayModule = system: {
            nixpkgs.overlays = [
              (add-unstable-pkgs system)
              (add-nvimx system)
            ];
          };
          hosts = {
            jonas-desktop = "x86_64-linux";
          };
        in
        builtins.mapAttrs (
          host: system:
          nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/${host}/configuration.nix
              ./nixosModules
              (externalDependencyOverlayModule system)
              home-manager.nixosModules.home-manager
              { networking.hostName = host; }
            ];
          }
        ) hosts;
    };
}

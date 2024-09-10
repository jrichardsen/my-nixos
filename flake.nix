{
  description = "My NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvimx.url = "github:jrichardsen/nvimx";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, nvimx, ... }: {
    nixosConfigurations = {
      "jonas-laptop" = let
        system = "x86_64-linux";
        add-unstable-pkgs = final: _prev: {
          unstable = import nixpkgs-unstable { inherit system; };
        };
        add-nvimx = final: _prev: {
          nvimx = nvimx.packages.${system}.nvimx;
        };
      in nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          { nixpkgs.overlays = [ add-unstable-pkgs add-nvimx ]; }
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jonas = import ./home.nix;
          }
        ];
      };
    };
  };
}

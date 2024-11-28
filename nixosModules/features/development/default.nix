{
  lib,
  pkgs,
  config,
  ...
}:
let
  cfg = config.features.development;
in
with lib;
{
  imports = [
    ./android.nix
    ./docker.nix
    ./documentation.nix
    ./networking.nix
    ./serial-ports.nix
  ];

  options = {
    features.development = {
      users = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "devUser" ];
        description = ''
          Users that should have access to development features.
        '';
      };
      groups = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "dialout" ];
        description = ''
          Groups that development users should have access to.
        '';
      };
    };
    users.users = mkOption {
      type = types.attrsOf (
        types.submodule (
          { name, ... }:
          {
            options.developer = mkOption {
              type = types.bool;
              default = false;
              description = ''
                Whether this user is a developer. If enabled, the user is integrated with the enabled development features in `features.development.*`
              '';
            };
            config = mkIf (elem name cfg.users) {
              extraGroups = cfg.groups;
            };
          }
        )
      );
    };
  };

  config = {
    # TODO: split these up and move them into home-manager
    environment.systemPackages = with pkgs; [
      python3
      nil
      nixpkgs-fmt
      clang-tools
      clang
      rustup
      opam
      cabal-install
      ghc
      haskell-language-server
      ormolu
      texlive.combined.scheme-full
    ];

  };
}

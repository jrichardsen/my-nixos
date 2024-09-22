# TODO: rework this:
# - move packages into home manager
# - split options and make them individually toggleable
{ pkgs, ... }:
{
  config = {
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

    # Enable OpenGL
    hardware.opengl.enable = true;

    # Enable android developement
    programs.adb.enable = true;

    # Enable docker
    virtualisation.docker.enable = true;
  };
}

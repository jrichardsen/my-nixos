{
  imports = [
    ./c.nix
    ./haskell.nix
    ./latex.nix
    ./nix.nix
    ./python.nix
    ./rust.nix
  ];

  config = {
    programs.nixvim.languages.enableByDefault = false;
  };
}

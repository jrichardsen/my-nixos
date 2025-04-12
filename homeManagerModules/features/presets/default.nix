{ lib, config, ... }:
let
  cfg = config.features.presets;
in
with lib;
{
  imports = [
    ./direnv.nix
    ./dunst.nix
    ./git.nix
    ./hyprland.nix
    ./firefox.nix
    ./flameshot.nix
    ./kitty.nix
    ./nixvim.nix
    ./rofi.nix
    ./starship.nix
    ./thunderbird.nix
    ./tmux.nix
    ./waybar.nix
    ./zathura.nix
    ./zsh.nix
  ];

  options = {
    features.presets = {
      enableAll = mkEnableOption "all presets by default";
    };
  };

  # TODO: introduce enableByDefault
  config = {
    features.presets = mkIf cfg.enableAll (mkDefault {
      direnv.enable = true;
      dunst.enable = true;
      firefox.enable = true;
      flameshot.enable = true;
      git.enable = true;
      hyprland.enable = true;
      kitty.enable = true;
      nixvim.enable = true;
      rofi.enable = true;
      starship.enable = true;
      thunderbird.enable = true;
      tmux.enable = true;
      waybar.enable = true;
      zathura.enable = true;
      zsh.enable = true;
    });
  };
}

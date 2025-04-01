{ lib, config, ... }:
let
  cfg = config.features.presets;
in
with lib;
{
  imports = [
    ./direnv.nix
    ./git.nix
    ./hyprland.nix
    ./firefox.nix
    ./flameshot.nix
    ./i3.nix
    ./i3status-rust.nix
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

  config = {
    features.presets = mkIf cfg.enableAll (mkDefault {
      direnv.enable = true;
      firefox.enable = true;
      flameshot.enable = true;
      git.enable = true;
      hyprland.enable = true;
      i3.enable = true;
      i3status-rust.enable = true;
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

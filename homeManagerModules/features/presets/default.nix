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
    ./i3.nix
    ./i3status-rust.nix
    ./kitty.nix
    ./rofi.nix
    ./starship.nix
    ./thunderbird.nix
    ./tmux.nix
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
      dunst.enable = true;
      git.enable = true;
      i3.enable = true;
      i3status-rust.enable = true;
      kitty.enable = true;
      rofi.enable = true;
      starship.enable = true;
      thunderbird.enable = true;
      tmux.enable = true;
      zathura.enable = true;
      zsh.enable = true;
    });
  };
}

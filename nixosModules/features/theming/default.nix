{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.theming;
in
with lib;
{
  imports = [
    ./nerdfont.nix
  ];

  options = {
    features.theming = {
      enable = mkEnableOption "theming";
    };
  };

  config = mkIf cfg.enable {
    stylix = {
      enable = true;

      image = mkDefault (
        pkgs.fetchurl {
          url = "https://www.pixelstalk.net/wp-content/uploads/image12/A-breathtaking-mountain-peak-towering-above-a-serene-turquoise-lake-illuminated-by-soft-morning-light.jpg";
          sha256 = "sha256-Ua9ktu0hqhiJDUbM571GisyjKLgSCqJ9ATAz1m09dvg=";
        }
      );
      base16Scheme = mkDefault "${pkgs.base16-schemes}/share/themes/onedark.yaml";
      polarity = "dark";

      fonts.sizes.desktop = 11;
    };
  };
}

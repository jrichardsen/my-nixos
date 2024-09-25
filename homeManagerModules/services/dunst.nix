{ pkgs, ... }:
{
  config = {
    services.dunst = {
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
        size = "32x32";
      };
      settings = {
        global = {
          width = 300;
          height = 300;
          transparency = 15;
          horizontal_padding = 10;
          frame_width = 0;
          format = "%s %p\n%b";
          font = "JetBrainsMono NerdFont 11";
        };
      };
    };
  };
}

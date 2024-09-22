{ pkgs, ... }:
{
  # TODO: maybe move this into shell
  config = {
    environment.systemPackages = with pkgs; [
      man-pages
      man-pages-posix
    ];

    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = true;
    };
  };
}

{
  lib,
  config,
  ...
}:
let
  cfg = config.features.laptop;
in
with lib;
{
  options = {
    features.laptop = {
      enable = mkEnableOption "features for laptop hardware";
    };
  };

  config = mkIf cfg.enable {
    services.batsignal.enable = true;
  };
}

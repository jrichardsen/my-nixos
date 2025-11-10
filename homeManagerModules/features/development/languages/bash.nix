{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.bash;
in
with lib;
{
  options = {
    features.development.languages.bash = {
      enable = mkEnableOption "Bash language tools";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      shellcheck
      shfmt

      # language server
      bash-language-server
    ];

    programs.nixvim.languages.bash.enable = true;
  };
}

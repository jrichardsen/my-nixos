{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.development.languages.latex;
in
with lib;
{
  options = {
    features.development.languages.latex = {
      enable = mkEnableOption "latex language tools";
    };
  };

  config = mkIf cfg.enable {
    programs.zathura.enable = mkDefault true;

    home.packages = with pkgs; [
      texlive.combined.scheme-full
      tex-fmt

      # language server
      texlab
    ];

    programs.nixvim.languages.latex.enable = true;
  };
}

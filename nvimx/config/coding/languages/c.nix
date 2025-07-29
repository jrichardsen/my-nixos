{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.languages.c;
in
with lib;
{
  options = {
    languages.c = {
      enable = mkEnableOption "C/C++ language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config =
    let
      formatCmd = if cfg.bundleTooling then "${pkgs.clang-tools}/bin/clang-format" else "clang-format";
    in
    mkIf cfg.enable {
      plugins.lsp.servers.clangd = {
        enable = true;
        package = mkIf (!cfg.bundleTooling) (mkDefault null);
      };
      plugins.conform-nvim.settings.formatters_by_ft.c = [ formatCmd ];
      plugins.conform-nvim.settings.formatters_by_ft.cpp = [ formatCmd ];
    };
}

{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.languages.nix;
in
with lib;
{
  options = {
    languages.nix = {
      enable = mkEnableOption "Nix language support";
      bundleTooling = mkEnableOption "bundled tooling";
    };
  };

  config = mkIf cfg.enable {
    plugins.lsp.servers.nil_ls = {
      enable = true;
      settings.formatting.command = [
        (if cfg.bundleTooling then "${pkgs.nixfmt-rfc-style}/bin/nixfmt" else "nixfmt")
      ];
    };
    # NOTE: try to get nixd to work
  };
  # NOTE: keybind to quickly expand/collapse singleton attrs
  # NOTE: fix indentation
  # NOTE: make path completions for directories omit the final /
}

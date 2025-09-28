{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.librewolf;
in
with lib;
{
  options = {
    features.presets.librewolf = {
      enable = mkEnableOption "librewolf presets";
    };
  };

  config = mkIf cfg.enable {

    programs.librewolf = {
      profiles = {
        default = {
          isDefault = true;
          search = {
            force = true;
            engines = {
              nix-packages = {
                name = "Nix Packages";
                urls = [ { template = "https://search.nixos.org/packages?query={searchTerms}"; } ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [
                  "@nixpkgs"
                  "@np"
                ];
              };
              nixos-options = {
                name = "NixOS Options";
                urls = [ { template = "https://search.nixos.org/options?query={searchTerms}"; } ];

                icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [
                  "@nixopts"
                  "@no"
                ];
              };
              home-manager-options = {
                name = "HomeManager Options";
                urls = [ { template = "https://home-manager-options.extranix.com/?query={searchTerms}"; } ];

                iconMapObj."16" = "https://home-manager-options.extranix.com/images/favicon.png";
                definedAliases = [
                  "@hmopts"
                  "@hm"
                ];
              };
              nixos-wiki = {
                name = "NixOS Wiki";
                urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
                iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
                definedAliases = [
                  "@nixwiki"
                  "@nw"
                ];
              };
            };
          };
          settings = {
            # Preserve browsing and download history
            "privacy.clearOnShutdown.history" = false;
            "privacy.clearOnShutdown.downloads" = false;
            "privacy.clearOnShutdown_v2.browsingHistoryAndDownloads" = false;

            "sidebar.verticalTabs" = true;
          };
          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            darkreader
            vimium
            bitwarden
          ];
        };
      };
    };

    stylix.targets.librewolf.profileNames = [ "default" ];
    systemInterface.applications.webBrowser = mkIf config.programs.librewolf.enable "librewolf";
  };
}

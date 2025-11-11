{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.zsh;
in
with lib;
{
  options = {
    features.presets.zsh = {
      enable = mkEnableOption "zsh presets";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      autosuggestion.enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];
      oh-my-zsh = {
        enable = true;
        plugins = [
          "starship"
          "history"
          "docker"

          "git"
        ];
      };
      sessionVariables = mkIf config.programs.nixvim.enable {
        MANPAGER = "nvim +Man!";

        # configuration of zsh-vi-mode
        ZVM_VI_SURROUND_BINDKEY = "s-prefix";
        ZVM_SYSTEM_CLIPBOARD_ENABLED = true;
      };
      shellAliases = {
        kssh = mkIf config.programs.kitty.enable "kitty +kitten ssh";
        v = mkIf config.programs.nixvim.enable "nvim";
        vim = mkIf config.programs.nixvim.enable "nvim";
        neo = "setxkbmap de neo_qwertz";
        noneo = "setxkbmap de";
      };
      initContent = ''
        unsetopt extendedglob

        function run_tms() {
          tms
        }
        zle -N run_tms
        bindkey "^[f" run_tms
      '';
    };
  };
}

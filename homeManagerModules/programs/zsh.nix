{
  config = {
    programs.zsh = {
      autosuggestion.enable = true;
      enableCompletion = true;
      historySubstringSearch.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [
          "starship"
          "history"
          "docker"

          "git"
        ];
      };
      shellAliases = {
        kssh = "kitty +kitten ssh";
        v = "nvim";
        vim = "nvim";
        neo = "setxkbmap de neo_qwertz";
        noneo = "setxkbmap de";
      };
      initExtra = ''
        unsetopt extendedglob

        bindkey -s "^f" "tms\n"
      '';
    };
  };
}

{ pkgs, ... }:
{
  config = {
    # Enable shell system-wide
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Enable shell completion
    programs.zsh.enableCompletion = true;
    # NOTE: try this:
    # programs.zsh.enableBashCompletion

    # TODO: minimize
    environment.systemPackages = with pkgs; [
      wget
      curl
      zip
      unzip
      git
      gnumake
      vim
      ripgrep
      fd
      fzf
      xsel
      tree
      dig
    ];

    documentation = {
      enable = true;
      man.enable = true;
      dev.enable = true;
    };
  };
}

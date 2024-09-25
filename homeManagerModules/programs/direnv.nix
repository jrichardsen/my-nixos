{ config, ... }:
{
  config = {
    programs.direnv = {
      enableZshIntegration = config.programs.zsh.enable;
      nix-direnv.enable = true;
    };
  };
}

{ config, ... }:
{
  config = {
    programs.starship = {
      enableZshIntegration = config.programs.zsh.enable;
    };
  };
}

{
  lib,
  osConfig ? { },
  ...
}:
with lib;
{
  imports = [ ./features ];

  options = {
    systemInterface = mkOption { type = types.submodule ../systemInterfaceModules; };
  };

  config = {
    systemInterface = mkIf (osConfig ? systemInterface) (
      # need to apply mkDefault one level lower to apply it to the individual
      # options and not the entire submodule
      mapAttrs (_: mkDefault) osConfig.systemInterface
    );
  };
}

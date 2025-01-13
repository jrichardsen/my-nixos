{ inputs, config, ... }:
{
  flake.modules = {
    homeManager = {
      nixvimIntegration =
        { lib, ... }:
        with lib;
        {
          imports = [ inputs.nixvim.homeManagerModules.nixvim ];
          options.programs.nixvim = mkOption {
            type = types.submoduleWith { modules = [ config.flake.modules.generic.nvimx ]; };
          };
        };
    };
    generic = {
      nvimx = {
        imports = [ ./config ];
        _module.args.utils = import ./utils;
      };
    };
  };

  perSystem =
    { pkgs, system, ... }:
    let
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nvimx = nixvim'.makeNixvim config.flake.modules.generic.nvimx;
      nvimxWithTooling = nvimx.extend { languages.bundleTooling = true; };
      nvimxNoIcons = nvimx.extend { style.icons.enable = false; };
    in
    {
      packages = {
        inherit nvimx;
        inherit nvimxWithTooling;
        inherit nvimxNoIcons;
      };
    };
}

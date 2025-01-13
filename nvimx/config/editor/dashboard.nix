{ lib, config, ... }:
{
  config = {
    plugins.dashboard = {
      enable = true;
      settings = {
        theme = "doom";
        hide = {
          statusline = false;
          tabline = false;
        };
        config = {
          header =
            lib.replicate 10 ""
            ++ [
              "███╗   ██╗ ██╗   ██╗ ██╗ ███╗   ███╗ ██╗  ██╗"
              "████╗  ██║ ██║   ██║ ██║ ████╗ ████║ ╚██╗██╔╝"
              "██╔██╗ ██║ ██║   ██║ ██║ ██╔████╔██║  ╚███╔╝ "
              "██║╚██╗██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║  ██╔██╗ "
              "██║ ╚████║  ╚████╔╝  ██║ ██║ ╚═╝ ██║ ██╔╝ ██╗"
              "╚═╝  ╚═══╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝ ╚═╝  ╚═╝"
            ]
            ++ lib.replicate 3 "";
          center =
            let
              mkAction = desc: key: icon: action: {
                inherit action;
                inherit desc;
                inherit key;
                inherit icon;
              };
              symbols = config.style.symbols.dashboard;
            in
            [
              (mkAction "  Find File                          " "f" symbols.find_file "Telescope find_files")
              (mkAction "  New File                           " "n" symbols.new_file "ene | startinsert")
              (mkAction "  Recent Files                       " "r" symbols.recent_files "Telescope oldfiles")
              (mkAction "  Find Text                          " "g" symbols.find_text "Telescope live_grep")
              (mkAction "  Restore Session                    " "s" symbols.restore_session
                "lua require(\"persistence\").load()"
              )
              (mkAction "  Quit                               " "q" symbols.quit "qa")
            ];
          footer = [ "" ];
        };
      };
    };
  };
}

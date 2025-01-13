{ lib, ... }:
with lib;
{
  options.style.symbols =
    let
      mkSymbolOption =
        default:
        mkOption {
          type = types.str;
          inherit default;
        };
    in
    {
      comments = {
        fix = mkSymbolOption "F";
        todo = mkSymbolOption "T";
        hack = mkSymbolOption "H";
        warn = mkSymbolOption "W";
        perf = mkSymbolOption "P";
        note = mkSymbolOption "N";
        test = mkSymbolOption "T";
      };
      dashboard = {
        find_file = mkSymbolOption "";
        new_file = mkSymbolOption "";
        recent_files = mkSymbolOption "";
        find_text = mkSymbolOption "";
        restore_session = mkSymbolOption "";
        quit = mkSymbolOption "";
      };
      diagnostics = {
        error = mkSymbolOption "E";
        warn = mkSymbolOption "W";
        info = mkSymbolOption "I";
        hint = mkSymbolOption "H";
      };
      file = {
        modified = mkSymbolOption "[+]";
        readonly = mkSymbolOption "[-]";
        unnamed = mkSymbolOption "[No name]";
      };
      git = {
        added = mkSymbolOption "+";
        modified = mkSymbolOption "~";
        removed = mkSymbolOption "-";
      };
      gitsigns = {
        add = mkSymbolOption "+";
        change = mkSymbolOption "~";
        delete = mkSymbolOption "_";
        topdelete = mkSymbolOption "‾";
        changedelete = mkSymbolOption "~";
        untracked = mkSymbolOption "";
      };
    };
}

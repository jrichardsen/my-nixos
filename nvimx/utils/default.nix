rec {
  mkCmdMap = mode: key: action: desc: {
    inherit mode;
    inherit key;
    inherit action;
    options = {
      inherit desc;
    };
  };

  mkLuaMap =
    mode: key: lua: desc:
    mkCmdMap mode key { __raw = lua; } desc;

  mkCmdMapN =
    key: action: desc:
    mkCmdMap [ "n" ] key action desc;

  mkLuaMapN =
    key: action: desc:
    mkLuaMap [ "n" ] key action desc;

  mkToggleMap =
    mode: key: setting: name:
    mkCmdMap mode key "<cmd>set ${setting}!<cr>" "Toggle ${name}";

  mkToggleMapN =
    key: setting: name:
    mkToggleMap [ "n" ] key setting "Toggle ${name}";
}

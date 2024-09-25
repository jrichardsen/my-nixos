{
  config = {
    programs.kitty = {
      theme = "One Dark";
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11.0;
      };
      keybindings = {
        "ctrl+plus" = "increase_font_size";
        "ctrl+minus" = "decrease_font_size";
        "ctrl+shift+q" = "noop";
        "ctrl+shift+w" = "noop";
      };
    };
  };
}

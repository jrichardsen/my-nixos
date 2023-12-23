{ config, pkgs, ... }:

{
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  xsession.windowManager.i3 = {
    enable = true;
    config = let
      modifier = "Mod4";
      refresh_i3status = "killall -SIGUSR1 i3status";
    in {
      modifier = modifier;
      fonts = {
        names = [ "JetBrainsMono" ];
        style = "NerdFont";
        size = 12.0;
      };
      floating.modifier = modifier;
      terminal = "kitty";
      keybindings = pkgs.lib.mkOptionDefault {
        "${modifier}+Shift+Return" = "exec firefox";
        "${modifier}+m" = "exec thunderbird";
        Print = "exec \"flameshot gui\"";
        "${modifier}+d" = "exec \"rofi -show drun\"";
        "${modifier}+x" = "exec \"rofi -show run\"";
        "${modifier}+Tab" = "exec \"rofi -show window\"";
        "${modifier}+odiaeresis" = "exec \"rofi -show combi\"";
        "${modifier}+Shift+P" = "exec --no-startup-id \"rofi-power\"";
        XF86PowerOff = "exec --no-startup-id \"rofi-power\"";
        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Ctrl+h" = "move workspace to output left";
        "${modifier}+Ctrl+j" = "move workspace to output down";
        "${modifier}+Ctrl+k" = "move workspace to output up";
        "${modifier}+Ctrl+l" = "move workspace to output right";
        "${modifier}+b" = "split h";
        "${modifier}+y" = "focus child";
        "${modifier}+u" = "workspace number 1";
        "${modifier}+i" = "workspace number 2";
        "${modifier}+o" = "workspace number 3";
        "${modifier}+Shift+u" = "move container to workspace number 1";
        "${modifier}+Shift+i" = "move container to workspace number 2";
        "${modifier}+Shift+o" = "move container to workspace number 3";
        XF86AudioRaiseVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5% && ${refresh_i3status}";
        XF86AudioLowerVolume = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5% && ${refresh_i3status}";
        XF86AudioMute = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && ${refresh_i3status}";
        XF86AudioMicMute = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && ${refresh_i3status}";
        XF86MonBrightnessUp = "exec --no-startup-id brightnessctl set +5% && ${refresh_i3status}";
        XF86MonBrightnessDown = "exec --no-startup-id brightnessctl set 5%- && ${refresh_i3status}";
      };
      window = {
        titlebar = false;
        border = 3;
        hideEdgeBorders = "smart";
      };
      focus = {
        newWindow = "none";
      };
      bars = [
        {
          fonts = {
            names = [ "JetBrainsMono" ];
            style = "NerdFont";
            size = 12.0;
          };
          position = "bottom";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml";
          trayOutput = "none";
          colors = {
            separator = "#666666";
            background = "#222222";
            statusline = "#dddddd";
            focusedWorkspace = {
              background = "#0088CC";
              border = "#0088CC";
              text = "#FFFFFF";
            };
            activeWorkspace = {
              background = "#333333";
              border = "#333333";
              text = "#FFFFFF";
            };
            inactiveWorkspace = {
              background = "#333333";
              border = "#333333";
              text = "#888888";
            };
            urgentWorkspace = {
              background = "#2F343A";
              border = "#900000";
              text = "#FFFFFF";
            };
          };
        }
      ];
    };
    extraConfig = ''
      no_focus [class="Zathura"]
    '';
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
      size = "32x32";
    };
    settings = {
      global = {
        width = 300;
        height = 300;
        transparency = 15;
        horizontal_padding = 10;
        frame_width = 0;
        format = "%s %p\n%b";
        font = "JetBrainsMono NerdFont 11";
      };
    };
  };

  programs.rofi = {
    enable = true;
    theme = ./programs/rofi/onedark.rasi;
    terminal = "${pkgs.kitty}/bin/kitty";
    extraConfig = {
      modes = "drun,run,window,combi";
      combi-modes = "window, drun, run";
      kb-custom-1 = "Alt+1,Super+d";
      kb-custom-2 = "Alt+2,Super+x";
      kb-custom-3 = "Alt+3,Super+Tab";
      kb-custom-4 = "Alt+4,Super+odiaeresis";
    };
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      default = {
        settings = {
          theme = {
            theme = "solarized-dark";
            overrides = {
              idle_bg = "#282c34";
              idle_fg = "#abb2bf";
              info_bg = "#61afef";
              info_fg = "#282c34";
              warning_bg = "#e5c07b";
              warning_fg = "#282c34";
              critical_bg = "#e86671";
              critical_fg = "#282c34";
              good_bg = "#98c379";
              good_fg = "#282c34";
            };
          };
          icons_format = "{icon}";
        };
        icons = "awesome4";
        theme = "solarized-dark";
        blocks = [
          {
            block = "cpu";
          }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:2) ";
          }
          {
            block = "disk_space";
            path = "/";
            info_type = "available";
            format = " $icon $available.eng(w:2) ";
          }
          {
            block = "backlight";
            device = "intel_backlight";
            invert_icons = true;
          }
          {
            block = "sound";
            headphones_indicator = true;
            click = [
              {
                button = "left";
                cmd = "pavucontrol";
              }
            ];
          }
          {
            block = "bluetooth";
            mac = "F4:4E:FD:00:1F:A6";
            click = [
              {
                button = "left";
                cmd = "blueman-manager";
              }
            ];
          }
          {
            block = "net";
            device = "enp3s0";
            format = " $icon {$ip|N/A} ";
          }
          {
            block = "net";
            device = "wlp2s0";
            format = " $icon $ssid{ ($signal_strength)|}: {$ip|N/A} ";
          }
          {
            block = "battery";
            format = " $icon $percentage ";
          }
          {
            block = "time";
            interval = 5;
            format = " $timestamp.datetime(f:'%a %d.%m %R') ";
          }
        ];
      };
    };
  };

  programs.kitty = {
    enable = true;
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

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    keyMode = "vi";
    mouse = true;
    plugins = with pkgs; [
      tmuxPlugins.onedark-theme
      tmuxPlugins.yank
    ];
    extraConfig = ''
      bind -n M-h previous-window
      bind -n M-l next-window
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator

      # decide whether we're in a Vim process
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h' 'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j' 'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k' 'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l' 'select-pane -R'

      bind-key -n 'C-Space' if-shell "$is_vim" 'send-keys C-Space' 'select-pane -t:.+'

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\' select-pane -l
      bind-key -T copy-mode-vi 'C-Space' select-pane -t:.+
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
  };
  xdg.configFile."nvim" = {
    source = ./programs/nvim;
    # have this recursive, so that Neovim can still update, i.e. edit lazy-lock.json
    recursive = true;
  };

  programs.git = {
    enable = true;
    userName = "jrichardsen";
    userEmail = "jonas.richardsen@gmail.com";
    extraConfig = {
      core = {
        autocrlf = "input";
        editor = "nvim";
      };
    };
  };

  programs.zsh = {
    enable = true;
    prezto = {
      enable = true;
      pmodules = [
        "environment"
        "terminal"
        "editor"
        "history"
        "directory"
        "spectrum"
        "utility"

        "syntax-highlighting"
        "history-substring-search"
        "autosuggestions"
        "git"
        "tmux"
        
        "completion"
        "prompt"
      ];
      editor = {
        dotExpansion = true;
        keymap = "vi";
      };
    };
    shellAliases = {
      kssh = "kitty +kitten ssh";
      vim = "nvim";
      neo = "setxkbmap de neo_qwertz";
      noneo = "setxkbmap de";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zathura = {
    enable = true;
    options = {
      highlight-active-color = "#ffffff";
      highlight-transparency = 0;
    };
  };

  home.file.bin = {
    source = ./programs/scripts;
    recursive = true;
  };
  home.sessionPath = [
    "$HOME/bin"
  ];

  home.packages = with pkgs; [
    # Messaging
    thunderbird
    element-desktop
    signal-desktop
    telegram-desktop

    # Utilities
    firefox
    libreoffice
    okular
    feh
    pympress
    vlc
    wireshark
    flameshot
    gnome.gnome-calendar
    owncloud-client
  ]; 

  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
}

{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.tmux;
in
with lib;
{
  options = {
    features.presets.tmux = {
      enable = mkEnableOption "tmux presets";
      tmuxSessionizer = mkEnableOption "tmux sessionizer" // {
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      baseIndex = 1;
      clock24 = true;
      escapeTime = 0;
      keyMode = "vi";
      mouse = true;
      terminal = "tmux-256color";
      plugins = with pkgs; [
        # NOTE: do more colorscheme-agnostic theming
        tmuxPlugins.onedark-theme
        tmuxPlugins.yank
      ];
      extraConfig = mkMerge [
        ''
          bind-key -n M-h previous-window
          bind-key -n M-l next-window
          bind-key -n M-H swap-window -t -1\; select-window -t -1
          bind-key -n M-L swap-window -t +1\; select-window -t +1

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
        ''
        (mkIf config.programs.kitty.enable ''
          set-option -sa terminal-features ',xterm-kitty:RGB'
        '')
      ];
    };
    home.packages = mkIf cfg.tmuxSessionizer [
      (pkgs.writeShellScriptBin "tms" ''
        #!/usr/bin/env bash
        # Tmux sessionizer adapted from 
        # https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find -L ~/.tms-targets/ -mindepth 2 -maxdepth 2 -type d -printf '%P\n'| fzf)
            if [ ! "$selected" ]; then
                exit 0
            fi
            selected_name=$(basename "$selected" | tr . _)
            selected=$(realpath ~/.tms-targets/$selected)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        # ignore errors, we don't care if it already exists
        tmux new-session -ds $selected_name -c $selected 2> /dev/null

        if [[ -n $TMUX ]]; then
            tmux switch-client -t $selected_name
        else
            tmux attach-session -t $selected_name
        fi
      '')
      (pkgs.writeShellScriptBin "tms-add" ''
        #!/usr/bin/env bash
        # Adds the current directory to tms by creating a symlink to it in ~/tms-favorites/

        dir=$(pwd -P)
        name=''${1:-$(basename $dir)}

        ln -s $dir ~/.tms-targets/favorites/$name
      '')
      (pkgs.writeShellScriptBin "tms-remove" ''
        #!/usr/bin/env bash
        # Removes the current directory from tms, can specify a different directory as optional argument

        dir=''${"1:-$" (pwd - P)}
        links=$(find ~/.tms-targets/favorites/ -lname $dir)
        if [ -n "$links" ]
        then
            rm $links
        else
            echo "No links to current directory found" 1>&2
            exit 1
        fi

      '')
    ];
  };
}

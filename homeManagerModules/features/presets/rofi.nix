{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.features.presets.rofi;
in
with lib;
{
  options = {
    features.presets.rofi = {
      enable = mkEnableOption "rofi presets";
      rofi-power = mkEnableOption "rofi-power" // {
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      theme = ../../../programs/rofi/onedark.rasi;
      inherit (config.systemInterface.applications) terminal;
      extraConfig = {
        modes = "drun,run,window,combi";
        combi-modes = "window, drun, run";
        kb-custom-1 = "Alt+1,Super+d";
        kb-custom-2 = "Alt+2,Super+x";
        kb-custom-3 = "Alt+3,Super+Tab";
        kb-custom-4 = "Alt+4,Super+odiaeresis";
      };
    };

    # NOTE: handle missing screen locker properly
    home.packages = optional cfg.rofi-power (
      pkgs.writeShellScriptBin "rofi-power" ''
        #!/usr/bin/env bash

        # Opens a rofi menu with various power options
        show_menu() {
        	# Menu options
        	lock_screen="Lock Screen"
        	standby="Suspend"
        	reboot="Reboot"
        	hibernate="Hibernate"
        	shutdown="Shutdown"

        	options="$lock_screen\n$standby\n$hibernate\n$reboot\n$shutdown"

        	# Open rofi menu, read chosen option
        	chosen="$(echo -e "$options" | $rofi_command "󰐥")"

        	# Match chosen option to command
        	case $chosen in
        	"" | $divider)
        		echo "No option chosen."
        		;;
        	$lock_screen)
                        ${defaultTo "break" config.systemInterface.applications.screenLocker}
        		;;
        	$standby)
        		systemctl suspend
        		;;
        	$hibernate)
        		systemctl hibernate
        		;;
        	$logout)
        		loginctl terminate-session $XDG_SESSION_ID
        		;;
        	$reboot)
        		systemctl reboot
        		;;
        	$shutdown)
        		systemctl poweroff
        		;;
        	*)
        		uptime
        		;;
        	esac
        }

        # Rofi command to pipe into, can add any options here
        rofi_command="rofi -dmenu -no-fixed-num-lines -i -p"
        # rofi_command="rofi -width 30 -dmenu -i -p rofi-power:"

        show_menu
      ''
    );
  };
}

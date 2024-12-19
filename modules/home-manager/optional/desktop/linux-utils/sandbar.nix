{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sandbar.enable =
      lib.mkEnableOption "enables sandbar";
  };

  config = lib.mkIf config.sandbar.enable {
    home = {
      packages = with pkgs; [
        sandbar
        pamixer
      ];
      file.".config/river/bar" = {
        text =
          /*
          bash
          */
          ''
            #!/usr/bin/env sh

            FIFO="$XDG_RUNTIME_DIR/sandbar"
            [ -e "$FIFO" ] && rm -f "$FIFO"
            mkfifo "$FIFO"

            while cat "$FIFO"; do :; done | sandbar \
            	-font "JetBrains Mono Nerd Font:Pixelsize" \
            	-active-fg-color "#000000" \
            	-active-bg-color "#98971a" \
            	-inactive-fg-color "#ebdbb2" \
            	-inactive-bg-color "#000000" \
            	-urgent-fg-color "#000000" \
            	-urgent-bg-color "#cc241d" \
            	-title-fg-color "#000000" \
            	-title-bg-color "#98971a"
          '';
        executable = true;
      };
      file.".config/river/status" = {
        text =
          /*
          bash
          */
          ''
            #!/bin/env sh

            cpu() {
            	cpu="$(grep -o "^[^ ]*" /proc/loadavg)"
            }

            memory() {
            	memory="$(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")"
            }

            disk() {
            	disk="$(df -h | awk 'NR==2{print $4}')"
            }

            datetime() {
            	datetime="$(date "+%a %d %b %I:%M %P")"
            }

            bat() {
            	read -r bat_status </sys/class/power_supply/BAT0/status
            	read -r bat_capacity </sys/class/power_supply/BAT0/capacity
            	bat="$bat_status $bat_capacity%"
            }

            vol() {
            	vol="$([ "$(pamixer --get-mute)" = "false" ] && printf "%s%%" "$(pamixer --get-volume)" || printf '-')"
            }

            display() {
            	echo "all status [$memory $cpu $disk] [$bat] [$vol] [$datetime]" >"$FIFO"
            }

            printf "%s" "$$" > "$XDG_RUNTIME_DIR/status_pid"
            FIFO="$XDG_RUNTIME_DIR/sandbar"
            [ -e "$FIFO" ] || mkfifo "$FIFO"
            sec=0
           
            while true; do
            	sleep 1 &
            	wait && {
            		[ $((sec % 15)) -eq 0 ] && memory
            		[ $((sec % 15)) -eq 0 ] && cpu
            		[ $((sec % 15)) -eq 0 ] && disk
            		[ $((sec % 60)) -eq 0 ] && bat
            		[ $((sec % 5)) -eq 0 ] && vol
            		[ $((sec % 5)) -eq 0 ] && datetime

            		[ $((sec % 5)) -eq 0 ] && display

            		sec=$((sec + 1))
            	}
            done
          '';
        executable = true;
      };
    };
  };
}

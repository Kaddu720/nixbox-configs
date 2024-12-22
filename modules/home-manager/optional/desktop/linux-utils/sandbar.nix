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

  # Docs to read when I come back to fix this: https://github.com/kolunmi/sandbar
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
            	-font "JetBrains Mono Nerd Font :size=12" \
              -hide-vacant-tags \
              -tags 5 dev web misc fun coms \
              -vertical-padding 5 \
            	-active-fg-color "#ebbcba" \
            	-active-bg-color "#191724" \
            	-inactive-fg-color "#e0def4" \
            	-inactive-bg-color "#191724" \
            	-urgent-fg-color "#191724" \
            	-urgent-bg-color "#eb6f92" \
            	-title-fg-color "#e0def4" \
            	-title-bg-color "#191724"
          '';
        executable = true;
      };
      file.".config/river/status" = {
        text =
          /*
          bash
          */
          ''
            #!/usr/bin/env sh

            cpu() {
            	cpu="cpu:$(grep -o "^[^ ]*" /proc/loadavg)"
            }

            memory() {
            	memory="mem:$(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")"
            }

            disk() {
            	disk="disk:$(df -h | awk 'NR==5{print $5}')"
            }

            datetime() {
            	datetime="$(date "+%a %d %b %I:%M %P")"
            }

            bat() {
            	read -r bat_status </sys/class/power_supply/BAT1/status
            	read -r bat_capacity </sys/class/power_supply/BAT1/capacity
            	bat="bat: $bat_status $bat_capacity%"
            }

            vol() {
            	vol="vol: $([ "$(pamixer --get-mute)" = "false" ] && printf "%s%%" "$(pamixer --get-volume)" || printf '-')"
            }

            display() {
            	echo "all status [$cpu $memory $disk] [$vol] [$bat] [$datetime]" >"$FIFO"
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

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
      packages = builtins.attrValues {
        inherit
          (pkgs)
          sandbar
          pamixer
          ;
      };
      file.".config/river/bar" = {
        text =
          /*
          sh
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
          sh
          */
          ''
            #!/usr/bin/env sh

            cpu() {
            	cpu=" $(grep -o "^[^ ]*" /proc/loadavg)%"
            }

            memory() {
            	memory=" $(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")"
            }

            disk() {
            	disk=" $(df -h | awk 'NR==5{print $5}')"
            }

            datetime() {
            	datetime="$(date "+%a %b %d %I:%M %p")"
            }

            bat() {
              if test -f "/sys/class/power_supply/BAT1/status"; then

                read -r bat_status </sys/class/power_supply/BAT1/status
                read -r bat_capacity </sys/class/power_supply/BAT1/capacity

                if [ "$bat_status" = "Discharging" ]; then
                  case 1 in
                    $((bat_capacity >= 75)) )
                          bat="$(printf "%s%%  " $bat_capacity)" ;;
                    $((bat_capacity >= 50)) )
                          bat="$(printf "%s%%  " $bat_capacity)" ;;
                    $((bat_capacity >= 25)) )
                          bat="$(printf "%s%%  " $bat_capacity)" ;;
                    $((bat_capacity >= 10)) )
                          bat="$(printf "%s%%  " $bat_capacity)" ;;
                    * )
                          bat="$(printf "%s%%  " $bat_capacity)" ;;
                  esac
                else
                  bat="$(printf "%s%% " $bat_capacity)"
                fi
              else
                bat=""
              fi
            }

            vol() {
            	vol="$([ "$(pamixer --get-mute)" = "false" ] && printf "  %s%%" "$(pamixer --get-volume)" || printf ' -')"
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
            		[ $((sec % 30)) -eq 0 ] && bat
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

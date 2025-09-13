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
    home = let
      sandbar-bar = pkgs.writeShellScript "sandbar-bar" ''
        FIFO="$XDG_RUNTIME_DIR/sandbar"
        [ -e "$FIFO" ] && rm -f "$FIFO"
        mkfifo "$FIFO"
        
        while cat "$FIFO"; do :; done | ${pkgs.sandbar}/bin/sandbar \
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
      sandbar-status = pkgs.writeShellScript "sandbar-status" ''
        cpu() {
          cpu=" $(vmstat 1 2 | tail -1 | awk '{print 100-$15}')%"
        }

        memory() {
          memory=" $(awk '/^MemTotal:/ {total=$2} /^MemAvailable:/ {avail=$2} END {used=total-avail; if(used>=1048576) printf "%.1fG", used/1048576; else printf "%.0fM", used/1024}' /proc/meminfo)"
        }

        disk() {
          disk=" $(df -h / | awk 'NR==2{print $5}')"
        }

        datetime() {
          datetime="$(date "+%a %b %d %I:%M %p")"
        }

        bat() {
          # Find available battery
          BAT_PATH=""
          for bat in /sys/class/power_supply/BAT*; do
            if [ -f "$bat/status" ] && [ -f "$bat/capacity" ]; then
              BAT_PATH="$bat"
              break
            fi
          done

          if [ -n "$BAT_PATH" ]; then
            read -r bat_status <"$BAT_PATH/status"
            read -r bat_capacity <"$BAT_PATH/capacity"

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
          vol_mute=$(pamixer --get-mute)
          if [ "$vol_mute" = "false" ]; then
            vol_level=$(pamixer --get-volume)
            new_vol="$(printf " %s%%" "$vol_level")"
          else
            new_vol=" -"
          fi
          
          # Only update if volume changed
          if [ "$new_vol" != "$vol" ]; then
            vol="$new_vol"
            vol_changed=1
          else
            vol_changed=0
          fi
        }

        display() {
          echo "all status [$cpu $memory $disk] [$vol] [$bat] [$datetime]" >"$FIFO"
        }

        printf "%s" "$$" > "$XDG_RUNTIME_DIR/status_pid"
        FIFO="$XDG_RUNTIME_DIR/sandbar"
        [ -e "$FIFO" ] || mkfifo "$FIFO"
        sec=0
        vol_changed=0

        while true; do
          sleep 1 &
          wait && {
            [ $((sec % 15)) -eq 0 ] && memory
            [ $((sec % 15)) -eq 0 ] && cpu
            [ $((sec % 15)) -eq 0 ] && disk
            [ $((sec % 30)) -eq 0 ] && bat
            vol  # Check volume every second
            [ $((sec % 5)) -eq 0 ] && datetime

            # Update display every 5 seconds OR when volume changes
            if [ $((sec % 5)) -eq 0 ] || [ "$vol_changed" -eq 1 ]; then
              display
              vol_changed=0
            fi

            sec=$((sec + 1))
          }
        done
      '';
    in {
      packages = builtins.attrValues {
        inherit
          (pkgs)
          sandbar
          pamixer
          ;
      };

      file.".config/river/bar".source = "${sandbar-bar}";
      file.".config/river/status".source = "${sandbar-status}";
    };
  };
}

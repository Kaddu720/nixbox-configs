{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sway.enable = lib.mkEnableOption "enables sway";
  };

  config = lib.mkIf config.sway.enable {
    # Fixed condition
    home.packages = with pkgs; [
      swaybg
      dunst
      pamixer
      playerctl
      brightnessctl
      wlr-randr
    ];

    wayland.windowManager.sway = {
      enable = true;
      checkConfig = true;
      systemd.enable = true;
      config = rec {
        # Start up Commands
        startup = [
          {command = "wlr-randr --output HDMI-A-1 --off";}
          {command = "dunst";}
          {command = "caffeine";}
          {command = "${pkgs.ghostty}/bin/ghostty";}
          {command = "zen";}
        ];

        # General Configs
        modifier = "Mod1";
        terminal = "ghostty";

        # KeyBinds
        keybindings = let
          modifier = "Mod1"; # Alt
          superKey = "Mod4"; # Windows/Super key
        in {
          # Application Launchers
          "${modifier}+Return" = "exec ${pkgs.ghostty}/bin/ghostty";
          "${modifier}+w" = "exec zen";
          "${modifier}+space" = "exec 'rofi -show drun'";
          "${modifier}+Shift+space" = "exec '$HOME/.config/scripts/rofi-menu.sh'";
          "${modifier}+Shift+q" = "kill";

          # Volume Controls
          "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 5";
          "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 5";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer --toggle-mute";

          # Change window focus
          "${modifier}+l" = "focus right";
          "${modifier}+h" = "focus left";
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";

          # Move window
          "${modifier}+Shift+l" = "move right";
          "${modifier}+Shift+h" = "move left";
          "${modifier}+Shift+j" = "move down";
          "${modifier}+Shift+k" = "move up";

          # Move to outputs
          "${modifier}+Shift+period" = "move container to output right";
          "${modifier}+Shift+comma" = "move container to output left";

          # Workspace Naviagtion
          "${modifier}+1" = "workspace dev";
          "${modifier}+2" = "workspace web";
          "${modifier}+3" = "workspace misc";
          "${superKey}+1" = "workspace fun";
          "${superKey}+2" = "workspace coms";

          # Move container to workspace
          "${modifier}+Shift+1" = "move container to workspace dev";
          "${modifier}+Shift+2" = "move container to workspace web";
          "${modifier}+Shift+3" = "move container to workspace misc";
          "${superKey}+Shift+1" = "move container to workspace fun";
          "${superKey}+Shift+2" = "move container to workspace coms";
        };

        # Workspace assignments to outputs
        workspaceOutputAssign = [
          {
            workspace = "dev";
            output = "DP-1";
          }
          {
            workspace = "web";
            output = "DP-1";
          }
          {
            workspace = "misc";
            output = "DP-1";
          }
          {
            workspace = "fun";
            output = "DP-2";
          }
          {
            workspace = "coms";
            output = "DP-2";
          }
        ];

        # Workspce app assignments
        window.commands = [
          {
            criteria = {app_id = "discord";};
            command = "move container to workspace fun";
          }
          {
            criteria = {app_id = "ghostty";};
            command = "move container to workspace dev";
          }
          {
            criteria = {app_id = "zen-beta";};
            command = "move container to workspace web";
          }
        ];

        # Window Decorations
        gaps = {
          inner = 5;
          outer = 2;
          smartBorders = "on";
          smartGaps = true;
        };
        colors = {
          focused = {
            border = lib.mkForce "#c78645";
            background = lib.mkForce "#191724";
            text = lib.mkForce "#8c9aa5";
            indicator = lib.mkForce "#c78645";
            childBorder = lib.mkForce "#c78645";
          };
          focusedInactive = {
            border = lib.mkForce "#3b83aa";
            background = lib.mkForce "#191724";
            text = lib.mkForce "#8c9aa5";
            indicator = lib.mkForce "#c78645";
            childBorder = lib.mkForce "#3b83aa";
          };
          unfocused = {
            border = lib.mkForce "#3b83aa";
            background = lib.mkForce "#191724";
            text = lib.mkForce "#8c9aa5";
            indicator = lib.mkForce "#c78645";
            childBorder = lib.mkForce "#3b83aa";
          };
          urgent = {
            border = lib.mkForce "#b4637a";
            background = lib.mkForce "#191724";
            text = lib.mkForce "#8c9aa5";
            indicator = lib.mkForce "#c78645";
            childBorder = lib.mkForce "#b4637a";
          };
          placeholder = {
            border = lib.mkForce "#c78645";
            background = lib.mkForce "#191724";
            text = lib.mkForce "#8c9aa5";
            indicator = lib.mkForce "#c78645";
            childBorder = lib.mkForce "#c78645";
          };
          background = lib.mkForce "#191724";
        };

        # Bar
        bars = [
          {
            statusCommand = "${pkgs.writeShellScript "sway-status" ''
              while true; do
                # CPU load
                cpu=" $(grep -o "^[^ ]*" /proc/loadavg)"

                # Memory usage
                memory=" $(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")"

                # Disk usage
                disk=" $(df -h | awk 'NR==5{print $5}')"

                # Volume
                if [ "$(${pkgs.pamixer}/bin/pamixer --get-mute)" = "false" ]; then
                  vol="  $(${pkgs.pamixer}/bin/pamixer --get-volume)%"
                else
                  vol=" -"
                fi

                # Battery (if exists)
                if test -f "/sys/class/power_supply/BAT1/status"; then
                  read -r bat_status </sys/class/power_supply/BAT1/status
                  read -r bat_capacity </sys/class/power_supply/BAT1/capacity

                  if [ "$bat_status" = "Discharging" ]; then
                    if [ $bat_capacity -ge 75 ]; then
                      bat="$bat_capacity%  "
                    elif [ $bat_capacity -ge 50 ]; then
                      bat="$bat_capacity%  "
                    elif [ $bat_capacity -ge 25 ]; then
                      bat="$bat_capacity%  "
                    elif [ $bat_capacity -ge 10 ]; then
                      bat="$bat_capacity%  "
                    else
                      bat="$bat_capacity%  "
                    fi
                  else
                    bat="$bat_capacity% "
                  fi
                else
                  bat=""
                fi

                # Date and time
                datetime=$(date "+%a %b %d %I:%M %p")

                # Output status
                echo "[ $cpu $memory $disk] [$vol] [$bat] [$datetime]"
                sleep 5
              done
            ''}";
            fonts = {
              names = ["JetBrains Mono Nerd Font"];
              size = 10.0;
            };

            colors = {
              statusline = "#e0def4";
              background = "#191724";
              focusedWorkspace = {
                background = "#191724";
                border = "#191724";
                text = "#ebbcba";
              };
              activeWorkspace = {
                background = "#191724";
                border = "#191724";
                text = "#ebbcba";
              };
              inactiveWorkspace = {
                background = "#191724";
                border = "#191724";
                text = "#e0def4";
              };
              urgentWorkspace = {
                background = "#eb6f92";
                border = "#eb6f92";
                text = "#191724";
              };
            };

            trayOutput = "none";
            extraConfig = ''
              position top
            '';
          }
        ];
      };

      extraConfig = ''
        # Mouse bindings
        floating_modifier Mod1 normal

        # Layout changes
        bindsym Mod1+Up layout splitv
        bindsym Mod1+Right layout splith
        bindsym Mod1+Down layout splitv
        bindsym Mod1+Left layout splith

        # Set default layout
        default_orientation horizontal

        # Window borders
        default_border pixel 2
      '';
    };

    services.kanshi = {
      enable = true;
      systemdTarget = "sway-session.target"; # Fixed target
    };

    home.file.".config/kanshi/config" = {
      text = ''
        profile Home-Box {
          output DP-1 mode 2560x1440@165Hz position 0,0 adaptive_sync on
          output DP-2 mode 1920x1080@60Hz position -1920,0
          output HDMI-A-1 disable
        }
        # profile Movie-Night {
        #   output DP-1 mode 2560x1440@165Hz position 0,0 adaptive_sync on
        #   output DP-2 mode 1920x1080@60Hz position -1920,0
        #   output HDMI-A-1
        # }
        profile Mobile-Docked {
          output DP-1 mode 2560x1440 position 0,0 adaptive_sync on
          output DP-2 mode 1920x1080 position -1920,0
          output eDP-1 disable
        }
        profile Mobile-Away {
          output DP-1 position 0,0 adaptive_sync on
          output eDP-1 mode 2256x1504@59.999001Hz position 0,0
        }
        profile Mobile-Box {
          output eDP-1 mode 2256x1504@59.999001Hz
        }
      '';
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    river.enable =
      lib.mkEnableOption "enables river";
  };

  # Docs: https://github.com/kolunmi/river
  config = lib.mkIf config.river.enable {
    home.packages = with pkgs; [
      swaybg
      dunst
      pamixer
      playerctl
      brightnessctl
      wlr-randr
    ];

    wayland.windowManager.river = {
      enable = true;
      extraConfig =
        /*
        sh
        */
        ''
          #!/bin/sh

          HOSTNAME=$(uname -n)
          HOME_DIR="${config.home.homeDirectory}"
          WALLPAPER="$HOME_DIR/.config/nixos/modules/common/static/dark_fractal.jpg"

          # Initialize monitor configuration
          case $HOSTNAME in
            Home-Box)
              wlr-randr --output HDMI-A-1 --off
              Primary_Monitor=DP-1
              Secondary_Monitor=DP-2
            ;;

            Mobile-Box)
              # Primary_Monitor=DP-1
              # Secondary_Monitor=DP-2
              Primary_Monitor=eDP-1
              Secondary_Monitor=eDP-1
            ;;

            *)
              # Fallback configuration
              Primary_Monitor=$(riverctl list-outputs | head -n1)
              Secondary_Monitor=$Primary_Monitor
            ;;
          esac

          # Set up desktop background
          if [ -e "$WALLPAPER" ]; then
            riverctl spawn "swaybg -m fill -i $WALLPAPER"
          fi

          # Set up sandbar
          riverctl spawn "$HOME_DIR/.config/river/status"
          riverctl spawn "$HOME_DIR/.config/river/bar"

          # Activate notification daemon
          riverctl spawn "dunst"

          # Set up caffeine
          riverctl spawn "caffeine"

          # Application launchers
          riverctl map normal Alt Return spawn 'riverctl set-focused-tags 1 && ghostty'
          riverctl map normal Alt W spawn zen
          riverctl map normal Alt Space spawn 'rofi -show drun'
          riverctl map normal Alt+Shift Space spawn "$HOME_DIR/.config/scripts/rofi-menu.sh"

          # Alt+Q to close the focused view
          riverctl map normal Alt+Shift Q close

          # Alt+Shift+E to exit river
          riverctl map normal Alt+Shift E exit

          # Alt+J and Alt+K to focus the next/previous view in the layout stack
          riverctl map normal Alt J focus-view next
          riverctl map normal Alt K focus-view previous

          # Alt+Shift+J and Alt+Shift+K to swap the focused view with the next/previous
          # view in the layout stack
          riverctl map normal Alt+Shift J swap next
          riverctl map normal Alt+Shift K swap previous

          # Alt+Period and Alt+Comma to focus the next/previous output
          riverctl map normal Alt Period focus-output next
          riverctl map normal Alt Comma focus-output previous

          # Alt+Shift+{Period,Comma} to send the focused view to the next/previous output
          riverctl map normal Alt+Shift Period send-to-output -current-tags next
          riverctl map normal Alt+Shift Comma send-to-output -current-tags previous

          # Alt+Return to bump the focused view to the top of the layout stack
          riverctl map normal Alt+Shift Return zoom

          # Alt+H and Super+L to decrease/increase the main ratio of rivertile(1)
          riverctl map normal Alt H send-layout-cmd rivertile "main-ratio -0.05"
          riverctl map normal Alt L send-layout-cmd rivertile "main-ratio +0.05"

          # Alt+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
          riverctl map normal Alt+Shift H send-layout-cmd rivertile "main-count +1"
          riverctl map normal Alt+Shift L send-layout-cmd rivertile "main-count -1"

          # Alt + Left Mouse Button to move views
          riverctl map-pointer normal Alt BTN_LEFT move-view

          # Alt + Right Mouse Button to resize views
          riverctl map-pointer normal Alt BTN_RIGHT resize-view

          # Alt + Middle Mouse Button to toggle float
          riverctl map-pointer normal Alt BTN_MIDDLE toggle-float


          # Tag Navigation
          # Primary Monitor (tags 1-3)
          for i in $(seq 1 3)
          do
            tags=$((1 << ($i - 1)))

            # Alt+[1-3] to focus tag [0-2] on Primary Monitor
            riverctl map normal Alt $i spawn "riverctl focus-output $Primary_Monitor && riverctl set-focused-tags $tags"

            # Alt+Shift+[1-3] to tag focused view with tag [0-2] on Primary Monitor
            riverctl map normal Alt+Shift $i spawn "riverctl focus-output $Primary_Monitor && riverctl set-view-tags $tags"

            # Alt+Control+[1-3] to toggle tag [0-2] of focused view
            riverctl map normal Alt+Control $i toggle-view-tags $tags
          done

          # Secondary Monitor (tags 4-5)
          for i in $(seq 1 2)
          do
            tags=$((8 << ($i - 1)))

            # Super+[1-2] to focus on tag [3-4] on Secondary Monitor
            riverctl map normal Super $i spawn "riverctl focus-output $Secondary_Monitor && riverctl set-focused-tags $tags"

            # Super+Shift+[1-2] to tag focused view with tag [3-4] on Secondary Monitor
            riverctl map normal Super+Shift $i spawn "riverctl focus-output $Secondary_Monitor && riverctl set-view-tags $tags"
          done

          # Alt+0 to focus all tags
          # Alt+Shift+0 to tag focused view with all tags
          all_tags=$(((1 << 32) - 1))
          riverctl map normal Alt 0 set-focused-tags $all_tags
          riverctl map normal Alt+Shift 0 set-view-tags $all_tags

          # Alt+{Up,Right,Down,Left} to change layout orientation
          riverctl map normal Alt Up    send-layout-cmd rivertile "main-location top"
          riverctl map normal Alt Right send-layout-cmd rivertile "main-location right"
          riverctl map normal Alt Down  send-layout-cmd rivertile "main-location bottom"
          riverctl map normal Alt Left  send-layout-cmd rivertile "main-location left"

          # Declare a passthrough mode. This mode has only a single mapping to return to
          # normal mode. This makes it useful for testing a nested wayland compositor
          riverctl declare-mode passthrough

          # Alt+F11 to enter passthrough mode
          riverctl map normal Alt F11 enter-mode passthrough

          # Alt+F11 to return to normal mode
          riverctl map passthrough Alt F11 enter-mode normal

          # Various media key mapping examples for both normal and locked mode which do
          # not have a modifier
          for mode in normal locked
          do
            # Control pulse audio volume with pamixer (https://github.com/cdemoulins/pamixer)
            riverctl map $mode None XF86AudioRaiseVolume  spawn 'pamixer -i 5'
            riverctl map $mode None XF86AudioLowerVolume  spawn 'pamixer -d 5'
            riverctl map $mode None XF86AudioMute         spawn 'pamixer --toggle-mute'

            # Control MPRIS aware media players with playerctl (https://github.com/altdesktop/playerctl)
            riverctl map $mode None XF86AudioMedia spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPlay  spawn 'playerctl play-pause'
            riverctl map $mode None XF86AudioPrev  spawn 'playerctl previous'
            riverctl map $mode None XF86AudioNext  spawn 'playerctl next'

            # Control screen backlight brightness with brightnessctl (https://github.com/Hummer12007/brightnessctl)
            riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
             riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
          done

          # Set background and border color
          riverctl border-color-focused 0xebbcba
          riverctl border-color-unfocused 0xc4a7e7
          riverctl border-width 0

          # Set keyboard repeat rate
          riverctl set-repeat 50 300

          # Terminal on tag 1, primary monitor
          riverctl rule-add -app-id 'com.mitchellh.ghostty' tags 1
          riverctl rule-add -app-id 'com.mitchellh.ghostty' output $Primary_Monitor

          # Browser on tag 2, primary monitor
          riverctl rule-add -app-id 'zen-beta' tags 2
          riverctl rule-add -app-id 'zen-beta' output $Primary_Monitor

          # Discord on tag 8, secondary monitor
          riverctl rule-add -app-id 'discord' tags 8
          riverctl rule-add -app-id 'discord' output $Secondary_Monitor

          # Floating windows
          riverctl rule-add -app-id 'pavucontrol' float
          riverctl rule-add -app-id 'nm-connection-editor' float
          riverctl rule-add -app-id 'blueman-manager' float

          # Client-side decorations
          riverctl rule-add -app-id "firefox" csd

          # Set the default layout generator to be rivertile and start it.
          # River will send the process group of the init executable SIGTERM on exit.
          riverctl default-layout rivertile
          rivertile -view-padding 6 -outer-padding 6 &
          riverctl default-attach-mode bottom

          # Configure Secondary Monitor
          riverctl focus-output $Secondary_Monitor
          riverctl send-layout-cmd rivertile "main-location right"
          riverctl output-attach-mode top
          riverctl set-focused-tags 8
          riverctl spawn "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland"

          # Configure Primary Monitor
          riverctl focus-output $Primary_Monitor
          riverctl send-layout-cmd rivertile "main-location left"
          riverctl set-focused-tags 1

          # Start applications on primary monitor
          riverctl spawn "ghostty"  # Terminal on tag 1
          riverctl set-focused-tags 2
          riverctl spawn "zen"      # Browser on tag 2
          riverctl set-focused-tags 1  # Return focus to tag 1

          # Start kanshi for display management
          riverctl spawn "kanshi"

          # Support zoom
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river
          systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        '';
    };
  #   services.kanshi = {
  #     enable = true;
  #     systemdTarget = "river-session.target";
  #   };
  #   home.file.".config/kanshi/config" = {
  #     text = ''
  #       profile Home-Box {
  #         output DP-1 mode 2560x1440@165Hz position 0,0 adaptive_sync on
  #         output DP-2 mode 1920x1080@60Hz position -1920,0
  #       }
  #       profile Movie-Night {
  #         output DP-1 mode 2560x1440@165Hz position 0,0 adaptive_sync on
  #         output DP-2 mode 1920x1080@60Hz position -1920,0
  #         output HDMI-A-1
  #       }
  #       profile Mobile-Docked {
  #         output DP-1 mode 2560x1440 position 0,0 adaptive_sync on
  #         output DP-2 mode 1920x1080 position -1920,0
  #         output eDP-1 disable
  #       }
  #       profile Mobile-Away {
  #         output DP-1 position 0,0 adaptive_sync on
  #         output eDP-1 mode 2256x1504@59.999001Hz position 0,0
  #       }
  #       profile Mobile-Box {
  #         output eDP-1 mode 2256x1504@59.999001Hz
  #       }
  #     '';
  #   };
   };
}

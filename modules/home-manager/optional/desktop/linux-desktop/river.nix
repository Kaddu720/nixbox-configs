{
  pkgs,
  lib,
  config,
  ...
}:
let
  wallpaper = builtins.path {
    path = ../../../../common/static/dark_fractal.jpg;
    name = "dark_fractal.jpg";
  };
in
{
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
          WALLPAPER="${wallpaper}"

          # Initialize monitor configuration
          case $HOSTNAME in
            Home-Box)
              # Check if wlr-randr is available and HDMI-A-1 exists before disabling it
              if command -v wlr-randr >/dev/null 2>&1; then
                if wlr-randr | grep -q "HDMI-A-1"; then
                  wlr-randr --output HDMI-A-1 --off
                fi
              fi
              Primary_Monitor=DP-1
              Secondary_Monitor=DP-2
            ;;

            Mobile-Box)
              Primary_Monitor=eDP-1
              Secondary_Monitor=eDP-1
            ;;

            *)
              # Fallback configuration - ensure we have valid outputs
              Primary_Monitor=$(riverctl list-outputs 2>/dev/null | head -n1)
              if [ -z "$Primary_Monitor" ]; then
                Primary_Monitor="Unknown"
              fi
              Secondary_Monitor=$Primary_Monitor
            ;;
          esac

          # Set up desktop background
          if [ -e "$WALLPAPER" ]; then
            riverctl spawn "swaybg -m fill -i $WALLPAPER"
          fi

          # Set up sandbar (check if scripts exist)
          if [ -x "$HOME_DIR/.config/river/status" ]; then
            riverctl spawn "$HOME_DIR/.config/river/status"
          fi
          if [ -x "$HOME_DIR/.config/river/bar" ]; then
            riverctl spawn "$HOME_DIR/.config/river/bar"
          fi

          # Activate notification daemon (check if available)
          if command -v dunst >/dev/null 2>&1; then
            riverctl spawn "dunst"
          fi

          # Set up caffeine (check if available)
          if command -v caffeine >/dev/null 2>&1; then
            riverctl spawn "caffeine"
          fi

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


          # Pre-calculate tag bit values
          TAG1=1   # 1 << 0
          TAG2=2   # 1 << 1  
          TAG3=4   # 1 << 2
          TAG4=8   # 1 << 3
          TAG5=16  # 1 << 4

          # Tag Navigation
          # Primary Monitor (tags 1-3)
          # Alt+1 to focus tag 1 on Primary Monitor
          riverctl map normal Alt 1 spawn "riverctl focus-output $Primary_Monitor; riverctl set-focused-tags $TAG1"
          riverctl map normal Alt+Shift 1 spawn "riverctl focus-output $Primary_Monitor; riverctl set-view-tags $TAG1"
          riverctl map normal Alt+Control 1 toggle-view-tags $TAG1

          # Alt+2 to focus tag 2 on Primary Monitor  
          riverctl map normal Alt 2 spawn "riverctl focus-output $Primary_Monitor; riverctl set-focused-tags $TAG2"
          riverctl map normal Alt+Shift 2 spawn "riverctl focus-output $Primary_Monitor; riverctl set-view-tags $TAG2"
          riverctl map normal Alt+Control 2 toggle-view-tags $TAG2

          # Alt+3 to focus tag 3 on Primary Monitor
          riverctl map normal Alt 3 spawn "riverctl focus-output $Primary_Monitor; riverctl set-focused-tags $TAG3"
          riverctl map normal Alt+Shift 3 spawn "riverctl focus-output $Primary_Monitor; riverctl set-view-tags $TAG3"
          riverctl map normal Alt+Control 3 toggle-view-tags $TAG3

          # Secondary Monitor (tags 4-5)
          # Super+1 to focus tag 4 on Secondary Monitor
          riverctl map normal Super 1 spawn "riverctl focus-output $Secondary_Monitor; riverctl set-focused-tags $TAG4"
          riverctl map normal Super+Shift 1 spawn "riverctl focus-output $Secondary_Monitor; riverctl set-view-tags $TAG4"

          # Super+2 to focus tag 5 on Secondary Monitor
          riverctl map normal Super 2 spawn "riverctl focus-output $Secondary_Monitor; riverctl set-focused-tags $TAG5"
          riverctl map normal Super+Shift 2 spawn "riverctl focus-output $Secondary_Monitor; riverctl set-view-tags $TAG5"

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

          # Set border width (no borders)
          riverctl border-width 0

          # Set keyboard repeat rate
          riverctl set-repeat 50 300

          # Tercminal on tag 1 (dev), primary monitor
          riverctl rule-add -app-id 'com.mitchellh.ghostty' tags 1
          riverctl rule-add -app-id 'com.mitchellh.ghostty' output $Primary_Monitor

          # Browser on tag 2 (web), primary monitor
          riverctl rule-add -app-id 'zen-beta' tags 2
          riverctl rule-add -app-id 'zen-beta' output $Primary_Monitor

          # Obsidian on tag 4 (misic), primary monitor
          riverctl rule-add -app-id 'obsidian' tags 4
          riverctl rule-add -app-id 'obsidian' output $Primary_Monitor

          # Discord on tag 8 (fun), secondary monitor
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

          # Configure Primary Monitor
          riverctl focus-output $Primary_Monitor
          riverctl send-layout-cmd rivertile "main-location left"
          riverctl set-focused-tags 1

          # Start applications with staggered delays
          {
            # riverctl spawn "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland" &
            sleep 1
            riverctl spawn "ghostty" &  # Terminal on tag 1
            sleep 1
            riverctl set-focused-tags 2
            riverctl spawn "zen" &      # Browser on tag 2  
            sleep 2
            riverctl set-focused-tags 4
            riverctl spawn "obsidian" & # Obsidian on tag 4
            riverctl set-focused-tags 1  # Return focus to tag 1
          } &

          # Start kanshi for display management (check if available)
          if command -v kanshi >/dev/null 2>&1; then
            riverctl spawn "kanshi"
          fi

          # Support zoom (check if dbus commands are available)
          if command -v dbus-update-activation-environment >/dev/null 2>&1; then
            dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=river
          fi
          if command -v systemctl >/dev/null 2>&1; then
            systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          fi
        '';
    };
    services.kanshi = {
      enable = true;
      systemdTarget = "river-session.target";
    };
    
    xdg.configFile."kanshi/config".text = ''
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
}

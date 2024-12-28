{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.services.desktop-config.linux.river == true) {
    home.packages = [
      pkgs.swaybg
    ];

    wayland.windowManager.river = {
      enable = true;
      extraConfig =
        /*
        bash
        */
        ''
          #!/bin/sh

          HOSTNAME=$(uname -n)

          # Initialize environmental variables
          case $HOSTNAME in
            Home-Box)
              Primary_Monitor=DP-1
              Seconday_Monitor=DP-2
            ;;

            Mobile-Box)
              Primary_Monitor=eDP-1
              Seconday_Monitor=eDP-1
            ;;
          esac

          # Set up desktop background
          [[ -e $HOME/.config/nixos/modules/common/static/dark_fractal.jpg ]] && riverctl spawn "swaybg -m fill -i $HOME/.config/nixos/modules/common/static/dark_fractal.jpg"

          # Set up sandbar
          riverctl spawn "$HOME/.config/river/status"
          riverctl spawn "$HOME/.config/river/bar"

          # Set up caffine
          caffeine &

          # activate power star mode, and set screen to power off after 5 min
          xset +dpms
          xset dpms 300

          # Terminal
          riverctl map normal Alt Return spawn ghostty

          # Browser
          riverctl map normal Alt W spawn zen

          # Rofi
          riverctl map normal Alt Space spawn 'rofi -show drun'

          # Rofi helper scripts
          riverctl map normal Alt+Shift Space spawn /home/noah/.config/scripts/rofi-menu.sh

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


          # Tag Naviagation
          # Primary_Monitor
          for i in $(seq 1 3)
          do
            tags=$((1 << ($i - 1)))

            # Alt+[1-9] to focus tag [0-8] on Primary_Monitor
            riverctl map normal Alt $i spawn "riverctl focus-output $Primary_Monitor && riverctl set-focused-tags $tags"

            # Alt+Shift+[1-9] to tag focused view with tag [0-8] on Primary_Monitor
            riverctl map normal Alt+Shift $i spawn "riverctl focus-output $Primary_Monitor && riverctl set-view-tags $tags"

            # Alt+Control+[1-9] to toggle focus of tag [0-8]
            # riverctl map normal Alt+Control $i toggle-focused-tags $tags

            # Alt+Shift+Control+[1-9] to toggle tag [0-8] of focused view
            riverctl map normal Alt+Control $i toggle-view-tags $tags
          done

          #Seconday_Monitor
          for i in $(seq 1 2)
          do
            tags=$((8 << ($i - 1)))

            # Super[1-9] to focus on tag [0-8] on Seconday_Monitor
            riverctl map normal Super $i spawn "riverctl focus-output $Seconday_Monitor && riverctl set-focused-tags $tags"

            # Super+Shift+[1-9] to tag focused view with tag [0-8] on Seconday_Monitor
             riverctl map normal Super+Shift $i spawn "riverctl focus-output $Seconday_Monitor && riverctl set-view-tags $tags"
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
          riverctl border-color-unfocused 0x31748f
          riverctl border-width 0

          # Set keyboard repeat rate
          riverctl set-repeat 50 300

          # Set up Rules
          riverctl rule-add -app-id 'zen-beta' tags 2
          riverctl rule-add -app-id 'zen-beta' output $Primary_Monitor

          riverctl rule-add -app-id 'discord' tags 8
          riverctl rule-add -app-id 'discord' output $Seconday_Monitor

          # Make all views with an app-id that starts with "float" and title "foo" start floating.
          riverctl rule-add -app-id 'float*' -title 'foo' float

          # Make all views with app-id "bar" and any title use client-side decorations
          riverctl rule-add -app-id "bar" csd

          # Set the default layout generator to be rivertile and start it.
          # River will send the process group of the init executable SIGTERM on exit.
          riverctl default-layout rivertile
          rivertile -view-padding 6 -outer-padding 6 &
          riverctl default-attach-mode bottom

          # Configure Seconday_Monitor
          riverctl focus-output $Seconday_Monitor
          riverctl send-layout-cmd rivertile "main-location right"
          riverctl set-focused-tags 8
          riverctl spawn "discord"

          # Configure Primary_Monitor
          riverctl focus-output $Primary_Monitor
          riverctl send-layout-cmd rivertile "main-location left"
          riverctl set-focused-tags 1
        '';
    };

    services.kanshi = {
      enable = true;
      systemdTarget = "river-session.target";
    };
    home.file.".config/kanshi/config" = {
      text = ''
        profile Home-Box {
          output DP-1 mode 2560x1440@165Hz position 1920,0 adaptive_sync on
          output DP-2 mode 1920x1080@60Hz position 0,0
          output HDMI-A-1 disable
        }
        profile Mobile-Box {
          output eDP-1 mode 2256x1504@59.999001Hz
        }
      '';
    };
  };
}

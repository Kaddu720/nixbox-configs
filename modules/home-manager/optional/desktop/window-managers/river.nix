{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.services.desktop-config.linux.river == true) {
    wayland.windowManager.river = {
      enable = true;
      extraConfig =
        /*
        bash
        */
        ''
          #!/bin/sh

          # Terminal
          riverctl map normal Alt Return spawn alacritty

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
          riverctl map normal Alt+Shift Period send-to-output next
          riverctl map normal Alt+Shift Comma send-to-output previous

          # Alt+Return to bump the focused view to the top of the layout stack
          riverctl map normal Alt+Shift Return zoom

          # Alt+H and Super+L to decrease/increase the main ratio of rivertile(1)
          riverctl map normal Alt H send-layout-cmd rivertile "main-ratio -0.05"
          riverctl map normal Alt L send-layout-cmd rivertile "main-ratio +0.05"

          # Alt+Shift+H and Super+Shift+L to increment/decrement the main count of rivertile(1)
          riverctl map normal Alt+Shift H send-layout-cmd rivertile "main-count +1"
          riverctl map normal Alt+Shift L send-layout-cmd rivertile "main-count -1"

          # # Alt+Alt+{H,J,K,L} to move views
          # riverctl map normal Alt+Alt H move left 100
          # riverctl map normal Alt+Alt J move down 100
          # riverctl map normal Alt+Alt K move up 100
          # riverctl map normal Alt+Alt L move right 100
          #
          # # Alt+Alt+Control+{H,J,K,L} to snap views to screen edges
          # riverctl map normal Alt+Alt+Control H snap left
          # riverctl map normal Alt+Alt+Control J snap down
          # riverctl map normal Alt+Alt+Control K snap up
          # riverctl map normal Alt+Alt+Control L snap right
          #
          # # Alt+Alt+Shift+{H,J,K,L} to resize views
          # riverctl map normal Alt+Alt+Shift H resize horizontal -100
          # riverctl map normal Alt+Alt+Shift J resize vertical 100
          # riverctl map normal Alt+Alt+Shift K resize vertical -100
          # riverctl map normal Alt+Alt+Shift L resize horizontal 100

          # Alt + Left Mouse Button to move views
          riverctl map-pointer normal Alt BTN_LEFT move-view

          # Alt + Right Mouse Button to resize views
          riverctl map-pointer normal Alt BTN_RIGHT resize-view

          # Alt + Middle Mouse Button to toggle float
          riverctl map-pointer normal Alt BTN_MIDDLE toggle-float

          for i in $(seq 1 9)
          do
              tags=$((1 << ($i - 1)))

              # Alt+[1-9] to focus tag [0-8]
              riverctl map normal Alt $i set-focused-tags $tags

              # Alt+Shift+[1-9] to tag focused view with tag [0-8]
              riverctl map normal Alt+Shift $i set-view-tags $tags

              # Alt+Control+[1-9] to toggle focus of tag [0-8]
              riverctl map normal Alt+Control $i toggle-focused-tags $tags

              # Alt+Shift+Control+[1-9] to toggle tag [0-8] of focused view
              riverctl map normal Alt+Shift+Control $i toggle-view-tags $tags
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
              # Eject the optical drive (well if you still have one that is)
              riverctl map $mode None XF86Eject spawn 'eject -T'

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
          riverctl background-color 0x002b36
          riverctl border-color-focused 0x93a1a1
          riverctl border-color-unfocused 0x586e75

          # Set keyboard repeat rate
          riverctl set-repeat 50 300

          # Make all views with an app-id that starts with "float" and title "foo" start floating.
          riverctl rule-add -app-id 'float*' -title 'foo' float

          # Make all views with app-id "bar" and any title use client-side decorations
          riverctl rule-add -app-id "bar" csd

          # Set the default layout generator to be rivertile and start it.
          # River will send the process group of the init executable SIGTERM on exit.
          riverctl default-layout rivertile
          rivertile -view-padding 6 -outer-padding 6 &

          # Set up sandbar
          riverctl spawn "$HOME/.config/river/status"
          riverctl spawn "$HOME/.config/river/bar"

          # Set up auxilary programs
          kanshi
          waybar
          discord
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
      '';
    };
  };
}

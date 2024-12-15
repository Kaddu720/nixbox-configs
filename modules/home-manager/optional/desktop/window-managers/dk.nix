{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.services.desktop-config.linux.dk == true) {
    home = {
      packages = with pkgs; [dk];
      file.".config/dk/dkrc" = {
        text =
          /*
          bash
          */
          ''
            #!/bin/sh

            # determine where to place the log file
            logfile="$HOME/.dkrc.log"
            [ -d "$HOME/.local/share/xorg" ] && logfile="$HOME/.local/share/xorg/dkrc.log"
            : > "$logfile"

            # (re)load sxhkd for keybinds
            if hash sxhkd >/dev/null 2>&1; then
                pkill sxhkd
                sxhkd -c "$HOME/.config/sxhkd/sxhkdrc" &
            fi

            # spawn a scratchpad terminal if not already (see sxhkdrc and rules for binds/setup)
            #pgrep -f "alacritty --class scratchpad" || alacritty --class scratchpad &

            { # compound command to redirect all output
                # workspace settings
                # ------------------------

                # default workspace '_' values used when allocating new workspaces
                # can be applied to all existing workspaces when passed 'apply' after ws=_
                dkcmd set ws=_ apply layout=tile master=1 stack=3 gap=10 msplit=0.55 ssplit=0.45

                HOSTNAME=$(uname -n)
                case $HOSTNAME in
                    Home-Box)
                        # initialize 6 workspaces (1-6) (default: 1/monitor)
                        dkcmd set numws=6

                        # Set up work spaces
                        dkcmd set static_ws=true \
                          ws=1 name="dev" mon=DP-1 \
                          ws=2 name="web" mon=DP-1 \
                          ws=3 mon=DP-1 \
                          ws=4 mon=DP-1 \
                          ws=5 name="fun" mon=DP-2 \
                          ws=6 name="docs" mon=DP-2

                        # rule class, instance, and title regexes (*ALWAYS* CASE INSENSITIVE)
                        # open window(s) on a specific workspace (assigned monitor)
                        dkcmd rule class="^alacritty$" ws=1 focus = true
                        dkcmd rule class="^zen-beta$" ws=2 focus = true
                        dkcmd rule class="^obsidian" ws=3 focus = true
                        dkcmd rule class="^discord$" ws=5
                        dkcmd rule class="^steam$" ws=5
                    ;;

                    Mobile-Box)
                        # initialize 5 workspaces (1-5) (default: 1/monitor)
                        dkcmd set numws = 5

                        # set up work spaces
                        dkcmd set static_ws=true \
                          ws=1 name="dev" mon=eDP-1 \
                          ws=2 name="web" mon=eDP-1 \
                          ws=3 name="fun" mon=eDP-1 \
                          ws=4 mon=eDP-1 \
                          ws=5 mon=DP-2

                        # rule class, instance, and title regexes (*ALWAYS* CASE INSENSITIVE)
                        # open window(s) on a specific workspace (assigned monitor)
                        dkcmd rule class="^alacritty$" ws=1 focus = true
                        dkcmd rule class="^zen-beta$" ws=2 focus = true
                        dkcmd rule class="^obsidian" ws=3 focus = true
                        dkcmd rule class="^discord$" ws=3
                    ;;
                esac


                # global settings
                # ---------------------

                # focus windows when receiving activation and enable focus-follows-mouse
                dkcmd set focus_open=true focus_urgent=true focus_mouse=true

                # place clients at the tail and ignore size hints on tiled windows
                dkcmd set tile_tohead=0 tile_hints=false

                # minimum width/height for resizing, and minimum allowed on-screen when moving
                dkcmd set win_minwh=50 win_minxy=10

                # disable smart gaps
                dkcmd set smart_gap=false smart_border=false

                # define mouse mod and move/resize buttons
                dkcmd set mouse mod=alt move=button1 resize=button3

                # obey motif border hints on windows that draw their own (steam, easyeffects, etc.)
                dkcmd set obey_motif=true

                # borders
                # ---------

                # traditional
                # set border width and colour for each window state
                # dkcmd set border width=$border_width colour focus='#6699cc' unfocus='#000000' urgent='#ee5555'

                # alternative
                # enable split borders and colours, width is overall width, outer_width consumes some of width.
                # outer_width must be less than width, outer_width of 0 will be single borders
                dkcmd set border width= 0 outer_width= 0

                # window rules
                # --------------

                # Keeps current window is postion when a new window is opened
                dkcmd set tile_tohead=0 tile_hints=false


                # open window(s) in a floating state
                dkcmd rule class="^(pavucontrol|steam|thunar)$" float=true
                # open window(s) with ignore_msg=true to avoid focus being grabbed and changing workspace
                # dkcmd rule class="^TelegramDesktop$" ignore_msg=true

                # set a window to never absorb other windows, like the xev event tester
                dkcmd rule title="^Event Tester$" no_absorb=true

                # Enable Scratch Pad rules
                dkcmd rule class="^scratchpad$" title="scratchpad" float=true scratch=true w=1280 h=520 x=center y=center

                # update or remove an existing rule with the same match patterns
                # dkcmd rule class="^firefox$" mon="HDMI-A-0"
                # dkcmd rule remove class="^firefox$"

                # apply current rule set to all existing windows (used mainly for WM restart)
                dkcmd rule apply '*'

                # delete all rules
                # dkcmd rule remove '*'

                # Set up polybar
                ~/.config/polybar/polybarLaunch.sh
                polybar-msg action pipewire hook 0
                # Launch Discord
                discord
            } >> "$logfile" 2>&1 # append responses

            # inform of any errors in a notification
            if grep -q 'error:' "$logfile"; then
                hash notify-send && notify-send -t 0 -u critical "dkrc has errors" \
                    "$(awk '/error:/ {sub(/^error: /, ""); gsub(/</, "\<"); print}' "$logfile")"
                exit 1
            fi

            exit 0
          '';

        executable = true;
      };
    };
  };
}

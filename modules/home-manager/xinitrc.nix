{ pkgs, lib, config, ... }: {
    options = {
        xinitrc.enable = 
            lib.mkEnableOption "config files for xinitrc";
    };

    config = lib.mkIf config.neovim.enable {    
        home.file = {
            ".xinitrc".text = ''
                
                #!/bin/sh

                # global xinitrc file, used by all X sessions started by xinit (startx)

                #Initialize other programs for desk top environments
                HOSTNAME=$(uname -n)

                #Set up display config
                case $HOSTNAME in
                    Home-Box)
                        xrandr --output DP-1 --primary --mode 2560x1440 --rate 60.00 \
                            --output DP-2 --mode 1920x1080 --rate 60.00 --left-of DP-1 \
                            --output 'HDMI-1' --off
                    ;;
                   
                    Mobile-Box)
                        xrandr --output eDP-1 --primary --mode 2256x1504 --rate 60.00
                    ;;
                esac

                # set custom key bindings in xmodmap
                [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

                # set walpaper image
                feh --bg-scale /home/noah/.config/nixos/modules/static/dark_fractal.jpg

                # Set pywal
                wal -R &

                # Start Picom
                picom --blur-method "dual_kawase" --daemon &

                # start up caffeine so that the desktop doesn't go the sleep when in full screen
                caffeine &

                # start us syncthing for syncing files
                syncthing &

                #Set us lock screen
                xautolock -time 5 -locker '~/.config/scripts/lockscreen.sh' -detectsleep &

                # activate power star mode, and set screen to power off after 5 min
                xset +dpms
                xset dpms 300

                #Activate dunst
                dunst &

                # Set up dwm blocks
                dwmblocks &

                exec dwm

                # launch Polybar
                #for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                #    MONITOR=$m polybar --reload home &
                #done

                #exec i3
            '';
            ".config/scripts/lockscreen.sh".text = ''
                #!/bin/sh
                
                # Turn dunst back on when the script ends
                trap "dunstctl set-paused false" EXIT
                
                # pause notifications
                dunstctl set-paused true

                # enable the lock screen
                slock
                
            '';
        };
    };
}

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
                        
                        xrandr --output DisplayPort-0 --primary --mode 2560x1440 --rate 60.00 \
                            --output DisplayPort-1 --mode 1920x1080 --rate 60.00 --left-of DisplayPort-0  \
                            --output 'HDMI-A-0' --off
                    ;;
                   
                    Mobile-Box)
                        xrandr --output eDP-1 --primary --mode 2256x1504 --rate 60.00
                    ;;
                esac

                # set custom key bindings in xmodmap
                [[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

                # set walpaper image
                feh --bg-scale /home/noah/.config/nixos-configs/modules/static/static/dark_fractal.jpg

                # Set pywal
                wal -R &

                # Start Picom
                picom --blur-method "dual_kawase" --daemon &

                # start up caffeine so that the desktop doesn't go the sleep when in full screen
                caffeine &

                # start us syncthing for syncing files
                syncthing &

                #Set us lock screen
                xautolock -time 5 -locker 'slock' &

                # activate power star mode, and set screen to power off after 5 min
                xset +dpms
                xset dpms 300

                # Set up dwm blocks
                dwmblocks &

                exec dwm

                # launch Polybar
                #for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                #    MONITOR=$m polybar --reload home &
                #done

                #exec i3
            '';
        };
    };
}

{ lib, config, ... }: {
    options = {
        dwlinit.enable = 
            lib.mkEnableOption "config files for to start dwl desktop environment";
    };

    config = lib.mkIf config.dwlinit.enable {    
        home.file = {
            ".dwlint.sh".text = ''
                
                #!/bin/sh

                #Initialize other programs for desk top environments
                HOSTNAME=$(uname -n)

                #Set up display config
                case $HOSTNAME in
                    Home-Box)
                        wlr-randr --output DP-1 --pos 0,0 --custom-mode 2560x1440@120Hz --adaptive-sync enabled \
                                --output DP-2 --pos -2560,0 \
                                --output 'HDMI-1' --off
                    ;;
                   
                    Mobile-Box)
                        wlr-randr --output eDP-1 --mode 2256x1504[@60Hz]
                    ;;
                esac

                # set walpaper image
                feh --bg-scale /home/noah/.config/nixos/modules/static/dark_fractal.jpg

                # Set pywal
                wal -R &

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
            '';
            ".config/scripts/lockscreen.sh" = {
                text = ''
                    #!/bin/sh
                    
                    # Turn dunst back on when the script ends
                    trap "dunstctl set-paused false" EXIT
                    
                    # pause notifications
                    dunstctl set-paused true

                    # enable the lock screen
                    slock
                '';
                executable = true;
            };
        };
    };
}

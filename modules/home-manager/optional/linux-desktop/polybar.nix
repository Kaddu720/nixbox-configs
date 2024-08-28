{ lib, config, ... }: {
    options = {
        polybar.enable = 
            lib.mkEnableOption "enables polybar";
    };

    config = lib.mkIf config.polybar.enable {

        home.file = {
            ".config/scripts/polybarLaunch.sh" = {
                text = ''
                    #!/bin/sh

                    # Terminate already running bar instances
                    killall -q polybar

                    case $HOSTNAME in
                        Home-Box)
                           MONITOR=DP-1 polybar --reload primary &
                           MONITOR=DP-2 polybar --reload secondary &
                        ;;
                       
                        Mobile-Box)
                            polybar --reload primary &
                        ;;
                    esac

                    polybar-msg action pipewire hook 0
                '';
                executable = true;
            };
            ".config/polybar/pb-volume.sh" = {
                source = ./pb-volume;
                executable = true;
            };
        };

        services.polybar = {
            enable = true;
            config = ./polybarrc;
            script = '''';
        };
    };
}

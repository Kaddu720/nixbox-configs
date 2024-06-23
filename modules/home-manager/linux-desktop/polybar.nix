{ lib, config, ... }: {
    options = {
        polybar.enable = 
            lib.mkEnableOption "enables polybar";
    };

    config = lib.mkIf config.polybar.enable {
        services.polybar = {
            enable = true;
            script = ''
                #!/bin/bash
                # Terminate already running bar instances
                killall -q polybar

                # Launch bar1 and bar2
                if type "xrandr"; then
                  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
                    MONITOR=$m polybar --reload home &
                  done
                else
                  polybar --reload home &
                fi
            '';
            config = ./polybarrc;
        };
    };
}

{ lib, config, ... }: {
    options = {
        skhd.enable = 
            lib.mkEnableOption "enables skhd";
    };

    config = lib.mkIf config.skhd.enable {    
        services.skhd = {
            enable = true;
            skhdConfig = ''
                # open terminal
                alt - return : open -n -a alacritty

                # open brower
                alt - w : open -n -a "Google Chrome"

                # change window focus
                alt - j : yabai -m window --forus south
                alt - k : yabai -m window --forus north
                alt - h : yabai -m window --forus west
                alt - l : yabai -m window --forus east

                # Change focus between external displays (left and right)
                alt - s : yabai -m display --focus west
                alt - g : yabai -m display --focus east

                # Modify the current layout
                alt - f : yabai -m config layout float #float
                alt - t : yabai -m config layout bsp # tiling
                alt - m : yabai -m config layout stack # monocole

                # swap windows
                shift + alt - j : yabai -m window --swap south
                shift + alt - k : yabai -m window --swap north
                shift + alt - h : yabai -m window --swap west
                shift + alt - l : yabai -m window --swap east

                # move a winodw to previous and next display
                shift + alt - s : yabai -m window --display west; yabai -m display --focus west;
                shift + alt - g : yabai -m window --display east; yabai -m display --focus east;

                # move window to a space #
                shift + alt - 1 : yabai -m window --space 1;
                shift + alt - 2 : yabai -m window --space 2;
                shift + alt - 3 : yabai -m window --space 3;
                shift + alt - 4 : yabai -m window --space 4;
                shift + alt - 5 : yabai -m window --space 5;
            '';
        };
    };
}

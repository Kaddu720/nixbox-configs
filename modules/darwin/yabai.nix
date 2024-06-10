{ lib, config, ... }: {
    options = {
        yabai.enable = 
            lib.mkEnableOption "enables yabai";
    };

    config = lib.mkIf config.yabai.enable {    

        services.yabai = {
            enable = true;
            enableScriptingAddition = true;
            config = {
                # Set Binary split layout option
                layout                       = "bsp";
                window_placement             = "second_child";

                # Padding
                top_padding                  = 10;
                bottom_padding               = 10;
                left_padding                 = 10;
                right_padding                = 10;
                window_gap                   = 10;

                # Mouse settings
                mouse_follows_focus          = "on";
                mouse_modifier               = "alt";
                mouse_action1                = "move";
                mouse_action2                = "resize";
                mouse_drop_action            = "swp";

            };

            extraConfig = ''
                    # rules
                    yabai -m rule --add app="^System Settings$" manage=off
            '';
        };
    };
}

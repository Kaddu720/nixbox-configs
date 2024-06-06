{ lib, config, ... }: {
    options = {
        yabai.enable = 
            lib.mkEnableOption "enables yabai";
    };

    config = lib.mkIf config.yabai.enable {    

        services.yabai = {
            enable = true;
            enableScriptingAddition = true;

            extraConfig = ''
                    # set binary split layout option
                    yabai -m config layout bsp
                    yabai -m config window_placement second_child

                    #padding
                    yabai -m config top_padding 10
                    yabai -m config bottom_padding 10
                    yabai -m config left_padding 10
                    yabai -m config right_padding 10
                    yabai -m config window_gap 10

                    # mouse settings
                    yabai -m config mouse_folows_focus on
                    yabai -m config mouse_modifier alt
                    yabai -m config mouse_action1 move
                    yabai -m config mouse_action2 resize
                    yabai -m config mouse_drop_action swp

                    # rules
                    yabai -m rule --add app="^System Preferences$" manage=off

                    echo "yabai configuration loaded.."
            '';
        };
    };
}

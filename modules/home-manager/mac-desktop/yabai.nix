{ lib, config, ... }: {
    options = {
        yabai.enable = 
            lib.mkEnableOption "enables yabai";
    };

    config = lib.mkIf config.yabai.enable {    

        home.file.".config/yabai/yabairc" = {
            text = ''

                # Set Binary split layout option
                yabai -m config layout bsp
                yabai -m window_placement second_child

                                # Padding
                yabai -m config top_padding    10
                yabai -m config bottom_padding 10
                yabai -m config left_padding   10
                yabai -m config right_padding  10
                yabai -m config window_gap     10

                # Mouse Settings
                yabai -m config mouse_follows_focus on
                yabai -m config mouse_modifier alt
                yabai -m config mouse_action1 move
                yabai -m config mouse_action2 resize
                yabai -m config mouse_drop_action swp

                # rules
                yabai -m rule --add app="^System Settings$" manage=off

                # External Bar rules
                yabai -m config external_bar all:40:0
            '';
        };
    };
}

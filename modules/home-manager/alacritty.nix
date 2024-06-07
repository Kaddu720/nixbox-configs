{ pkgs, lib, config, ... }: {
    options = {
        alacritty.enable = 
            lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {    

        home.packages = with pkgs; [ alacritty ];

        home.file = {
            ".config/alacritty/alacritty.toml".text = ''
                [env]
                term = "xterm-256color"

                [window]
                padding = { x = 10, y = 5 }
                dynamic_padding = true

                decorations = "Buttonless"
                opacity = 0.8
                blur = true

                [mouse]
                hide_when_typing = true

                [font]
                size = 12.0

                [font.normal]
                family = "Hack Nerd Font Mono"
                style = "Regular"

                [colors.primary]
                background = "#191724"
                foreground = "#c7c4c4"

                [colors.normal]
                black = "#191724"
                red = "#aa7264"
                green = "#bb5c3a"
                yellow = "#c78645"
                blue = "#3b83aa"
                magenta = "#8c9aa5"
                cyan = "#563ea9"
                white = "#c7c4c4"

                [colors.bright]
                black = "#58504e"
                red = "#aa7264"
                green = "#bb5c3a"
                yellow = "#c78645"
                blue = "#3b83aa"
                magenta = "#8c9aa5"
                cyan = "#563ea9"
                white = "#c7c4c4"
            '';
        };
    };
}

{ pkgs, lib, config, ... }: {
    options = {
        alacritty.enable = 
            lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {    

        programs.alacritty = {
            enable = true;
            settings = {
                
                shell = {
                    #username on the work machine is "noahwilson"
                    program = if "${config.home.username}" == "noahwilson" then "/usr/local/bin/fish" else "${pkgs.fish}/bin/fish";
                };

                env = {
                    term = "xterm-256color";
                };

                window = {
                    padding = {
                        x = 10;
                        y = 5;
                    };
                    dynamic_padding = true;
                    decorations = "Buttonless";
                    opacity = 0.8;
                    blur = true;
                };

                font = {
                    size = if "${config.home.username}" == "noahwilson" then 18 else 12;
                    normal = {
                        family = "Hack Nerd Font Mono";
                        style = "Regular";
                    };
                };

                colors = {
                    primary = {
                        background = "#191724";
                        foreground = "#c7c4c4";
                    };
                    normal = {
                        black = "#191724";
                        red = "#aa7264";
                        green = "#bb5c3a";
                        yellow = "#c78645";
                        blue = "#3b83aa";
                        magenta = "#8c9aa5";
                        cyan = "#563ea9";
                        white = "#c7c4c4";
                    };
                    bright = {
                        black = "#58504e";
                        red = "#aa7264";
                        green = "#bb5c3a";
                        yellow = "#c78645";
                        blue = "#3b83aa";
                        magenta = "#8c9aa5";
                        cyan = "#563ea9";
                        white = "#c7c4c4";
                    };
                };
            };
        };
    };
}

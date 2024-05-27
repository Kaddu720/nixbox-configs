{ pkgs, lib, config, ... }: {
    options = {
        alacritty.enable = 
            lib.mkEnableOption "enables alacritty";
    };

    config = lib.mkIf config.alacritty.enable {    

        home.packages = with pkgs; [ alacritty ];

        home.file = {
            ".config/alacritty/alacritty.toml".text = ''
                [window]
                padding = { x = 10, y = 5 }
                dynamic_padding = true

                [font]
                size = 12.0

                [font.normal]
                family = "Hack Nerd Font Mono"
                style = "Regular"

                [mouse]
                hide_when_typing = true

                [env]
                term = "xterm-256color"
            '';
        };
    };
}

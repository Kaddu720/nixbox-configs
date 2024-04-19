{ pkgs, lib, config, ... }: {
    options = {
        alacirtty.enable = 
            lib.mkEnableOption "enables alacirtty";
    };

    config = lib.mkIf config.alacirtty.enable {    

        home.packages = with pkgs; [ alacritty ];

        home.file = {
            ".config/alacirtty/alacirtty.toml".text = ''
                [shell]
                program = "fish"

                [font]
                size = 12.0

                [font.normal]
                family = "Hack Nerd Font Mono"

                [mouse]
                hide_when_typing = true
            '';
        };
    };
}

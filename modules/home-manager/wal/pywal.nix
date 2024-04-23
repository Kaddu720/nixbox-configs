{ pkgs, lib, config, ... }: {
    options = {
        pywal.enable = 
            lib.mkEnableOption "enables pywal";
    };

    config = lib.mkIf config.pywal.enable {    
        home.packages = with pkgs; [ pywal ];

        home.file = {
            ".config/wal/templates".source = ./templates;
            ".cache/wal/colors.nix" = {
                executable = true;
                text = ''
                    {
                        "wallpaper": "/home/noah/.config/nixos/modules/static/dark_fractal.jpg",
                        "alpha": "100",

                        "special": {
                            "background": "#191724",
                            "foreground": "#c7c4c4",
                            "cursor": "#c7c4c4"
                        },
                        "colors": {
                            "color0": "#191724",
                            "color1": "#aa7264",
                            "color2": "#bb5c3a",
                            "color3": "#c78645",
                            "color4": "#3b83aa",
                            "color5": "#8c9aa5",
                            "color6": "#563ea9",
                            "color7": "#c7c4c4",
                            "color8": "#58504e",
                            "color9": "#aa7264",
                            "color10": "#bb5c3a",
                            "color11": "#c78645",
                            "color12": "#3b83aa",
                            "color13": "#8c9aa5",
                            "color14": "#563ea9",
                            "color15": "#c7c4c4"
                        }
                    }
                '';
            };
        };
    };
}

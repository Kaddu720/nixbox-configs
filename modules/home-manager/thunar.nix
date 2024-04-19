{ pkgs, lib, config, ... }: {
    options = {
        thunar.enable = 
            lib.mkEnableOption "enables thunar file manager";
    };

    config = lib.mkIf config.thunar.enable {    

        home.packages = with pkgs; [ 
            lxappearance
            materia-theme
            papirus-icon-theme
            xfce.thunar
            xfce.thunar-volman
            xfce.thunar-archive-plugin
        ];

        home.file = {
            ".config/gtk-3.0/settings.ini".text = ''
                [Settings]
                gtk-theme-name=Materia-dark
                gtk-icon-theme-name=Papirus-Dark
                gtk-font-name=Hack 10
                gtk-cursor-theme-size=0
                gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
                gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
                gtk-button-images=0
                gtk-menu-images=0
                gtk-enable-event-sounds=1
                gtk-enable-input-feedback-sounds=1
                gtk-xft-antialias=1
                gtk-xft-hinting=1
                gtk-xft-hintstyle=hintmedium
            '';
        };

    };
}

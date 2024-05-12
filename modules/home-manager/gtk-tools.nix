{ pkgs, lib, config, ... }: {
    options = {
        gtk-tools.enable = 
            lib.mkEnableOption "enables gtk applications file manager";
    };

    config = lib.mkIf config.gtk-tools.enable {    

        home.packages = with pkgs; [ 
            lxappearance
            rose-pine-gtk-theme
            rose-pine-icon-theme
            rose-pine-cursor
            xfce.thunar
            xfce.thunar-volman
            xfce.thunar-archive-plugin
        ];

        xdg.mimeApps.defaultApplications."inode/directory" = "thunar";

        home.file = {
            ".config/gtk-3.0/settings.ini".text = ''
                [Settings]
                gtk-theme-name=rose-pine
                gtk-icon-theme-name=rose-pine
                gtk-font-name=Sans 10
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
                gtk-xft-rgba=none
            '';
        };

    };
}

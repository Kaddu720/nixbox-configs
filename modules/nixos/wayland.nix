{ pkgs, lib, config, ... }: {
    options = {
        wayland.enable = 
            lib.mkEnableOption "enables wayland";
    };

    config = lib.mkIf config.wayland.enable {    
        # manage input devices
        services.libinput.enable = true;

        #enable greetd greeter
        services.greetd.settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --remember --remember-session --cmd 'dwl \> /tmp/dwltags'";
            };
        };

        #set up wayland
        programs.sway = {
            enable = true;
            wrapperFeatures.gtk = true;
        };
            
    };
}

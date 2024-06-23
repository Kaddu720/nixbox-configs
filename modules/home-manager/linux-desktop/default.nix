{ lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dk.nix
        ./sxhkd.nix
        ./polybar.nix
        ./picom.nix
        ./dmenu/dmenu.nix
        ./gtk-theme.nix
    ];

    xinitrc.enable = 
        lib.mkDefault true;
    dk.enable = 
        lib.mkDefault true;
    sxhkd.enable = 
        lib.mkDefault true;
    polybar.enable =
        lib.mkDefault true;
    picom.enable = 
        lib.mkDefault true;
    dmenu.enable = 
        lib.mkDefault true;
    gtk-theme.enable = 
        lib.mkDefault true;
}


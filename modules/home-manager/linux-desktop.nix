{ lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwm/dwm.nix
        ./dwmblocks/dwmblocks.nix
        ./picom.nix
        ./dmenu/dmenu.nix
        ./gtk-theme.nix
    ];

    xinitrc.enable = 
        lib.mkDefault true;
    dwm.enable = 
        lib.mkDefault true;
    dwmblocks.enable = 
        lib.mkDefault true;
    picom.enable = 
        lib.mkDefault true;
    dmenu.enable = 
        lib.mkDefault true;
    gtk-theme.enable = 
        lib.mkDefault true;
}


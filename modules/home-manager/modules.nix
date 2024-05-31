{ pkgs, lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwm/dwm.nix
        ./dwmblocks/dwmblocks.nix
        ./dwl/dwl.nix
        ./dwl/dwlinit.nix
        ./picom.nix
        ./wal/pywal.nix
        ./dmenu/dmenu.nix
        ./gtk-tools.nix
    ];
}

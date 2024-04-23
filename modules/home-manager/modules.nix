{ pkgs, lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwm/dwm.nix
        ./dwmblocks/dwmblocks.nix
        ./picom.nix
        ./wal/pywal.nix
        ./dmenu/dmenu.nix
        ./gtk-tools.nix
    ];
}

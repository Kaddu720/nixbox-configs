{ pkgs, lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwl/dwl.nix
        ./dwmblocks/dwmblocks.nix
        ./picom.nix
        ./wal/pywal.nix
        ./dmenu/dmenu.nix
        ./gtk-tools.nix
    ];
}

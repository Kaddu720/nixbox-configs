{ pkgs, lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwl/dwl.nix
        ./picom.nix
        ./wal/pywal.nix
        ./dmenu/dmenu.nix
        ./gtk-tools.nix
    ];
}

{ pkgs, lib, ... }: {
    imports = [
        ./xinitrc.nix
        ./dwm/dwm.nix
        ./dwmblocks/dwmblocks.nix
        ./picom.nix
        ./wal/pywal.nix
        ./dmenu/dmenu.nix
        ./thunar.nix
        ./fish/fish.nix
        ./alacirtty.nix
        ./neovim.nix
        ./tmux.nix
    ];
}

{ pkgs, lib, ... }: {
    imports = [
        ./xserver.nix
        ./wayland.nix
        ./pipewire.nix
    ];
}

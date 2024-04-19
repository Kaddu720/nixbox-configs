{ pkgs, lib, ... }: {
    imports = [
        ./xserver.nix
        ./pipewire.nix
    ];
}

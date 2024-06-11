{ lib, ... }: {
    imports = [
        ./kmonad.nix
    ];

    kmonad.enable = 
        lib.mkDefault true;
}

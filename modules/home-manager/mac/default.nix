
{ lib, ... }: {
    imports = [
        ./skhd.nix
    ];

    skhd.enable = 
        lib.mkDefault true;
}



{ lib, ... }: {
    imports = [
        ./skhd.nix
        ./yabai.nix
    ];

    skhd.enable = 
        lib.mkDefault true;
    yabai.enable = 
        lib.mkDefault true;
}


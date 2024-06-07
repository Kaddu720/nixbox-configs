
{ lib, ... }: {
    imports = [
        ./yabai.nix
        ./skhd.nix
    ];

    yabai.enable = 
        lib.mkDefault true;
    skhd.enable = 
        lib.mkDefault true;
}

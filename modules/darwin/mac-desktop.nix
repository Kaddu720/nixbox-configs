
{ lib, ... }: {
    imports = [
        ./yabai.nix
        ./skhd.nix
    ];

    yabi.enable = 
        lib.mkDefault true;
    skhd.enable = 
        lib.mkDefault true;
}

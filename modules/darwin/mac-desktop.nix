
{ lib, ... }: {
    imports = [
        ./yabai.nix
    ];

    yabai.enable = 
        lib.mkDefault true;
}

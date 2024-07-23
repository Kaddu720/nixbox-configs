{ lib, ... }: {
    imports = [
        ./skhd.nix
        ./sketchybar.nix
        ./yabai.nix
    ];

    skhd.enable = 
        lib.mkDefault true;
    yabai.enable = 
        lib.mkDefault true;
    sketchybar.enable =
        lib.mkDefault true;
}

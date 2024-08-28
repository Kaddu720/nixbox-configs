{lib, ...}: {
  imports = [
    ./amethyst.nix
    ./skhd.nix
    ./sketchybar.nix
  ];

  amethyst.enable =
    lib.mkDefault true;
  skhd.enable =
    lib.mkDefault true;
  sketchybar.enable =
    lib.mkDefault true;
}

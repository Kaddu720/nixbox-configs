{lib, ...}: {
  imports = [
    ./aerospace.nix
    ./skhd.nix
  ];

  aerospace.enable =
    lib.mkDefault true;
  skhd.enable =
    lib.mkDefault true;
}

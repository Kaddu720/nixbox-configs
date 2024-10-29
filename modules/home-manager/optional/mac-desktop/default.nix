{lib, ...}: {
  imports = [
    ./aerospace.nix
  ];

  aerospace.enable =
    lib.mkDefault true;
}

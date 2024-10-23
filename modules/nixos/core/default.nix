{lib, ...}: {
  imports = [
    ./xserver.nix
    ./pipewire.nix
    ./thunar.nix
  ];

  xserver.enable =
    lib.mkDefault true;
  pipewire.enable =
    lib.mkDefault true;
  thunar.enable =
    lib.mkDefault true;
}

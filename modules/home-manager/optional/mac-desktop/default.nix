{lib, ...}: {
  imports = [
    ./aerospace.nix
    ./skhd.nix
  ];

  aerospace.enable =
    lib.mkDefault true;
  skhd.enable =
    lib.mkDefault true;

  #enable programs as services
  services = {
    skhd.enable = true;
  };

  homebrew.casks = [
    "nikitabobko/tap/aerospace"
    "hiddenbar"
  ];
}

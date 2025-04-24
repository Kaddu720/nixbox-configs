{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./helper-scripts.nix
    ./river.nix
    ./rofi.nix
    ./gtk-theme.nix
    ./sandbar.nix
    ./swayidle.nix
  ];

  config = lib.mkIf (config.services.desktop-config.linuxDesktop == true) {
    dunst.enable = true;
    helper-scripts.enable = true;
    river.enable = true;
    rofi.enable = true;
    gtk-theme.enable = true;
    sandbar.enable = true;
    swayidle.enable = true;

    # Install Packages
    home.packages = builtins.attrValues {
      inherit
        (pkgs)
        caffeine-ng
        dunst
        feh
        font-awesome_5
        pavucontrol
        xautolock
        ;
      inherit
        (pkgs.nerd-fonts)
        jetbrains-mono
        ;
    };
  };
}

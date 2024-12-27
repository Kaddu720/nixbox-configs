{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./helper-scripts.nix
    ./xinitrc.nix
    ./polybar.nix
    ./picom.nix
    ./rofi.nix
    ./gtk-theme.nix
    ./sandbar.nix
  ];

  config = lib.mkIf (config.services.desktop-config.linux.linuxUtils == true) {
    dunst.enable = true;
    helper-scripts.enable = true;
    xinitrc.enable = true;
    polybar.enable = true;
    picom.enable = true;
    rofi.enable = true;
    gtk-theme.enable = true;
    sandbar.enable = true;

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
        hack
        jetbrains-mono
        ;
    };
  };
}

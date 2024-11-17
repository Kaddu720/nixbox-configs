{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dunst.nix
    ./xinitrc.nix
    ./polybar.nix
    ./picom.nix
    ./rofi.nix
    ./gtk-theme.nix
  ];

  config = lib.mkIf (config.services.desktop-config.linux.linuxUtils == true) {
    dunst.nix = true;
    xinitrc.enable = true;
    polybar.enable = true;
    picom.enable = true;
    rofi.enable = true;
    gtk-theme.enable = true;

    # Install Packages
    home.packages = with pkgs; [
      caffeine-ng
      dunst
      feh
      font-awesome_5
      (nerdfonts.override {fonts = ["Hack"];})
      pavucontrol
      xautolock
    ];
  };
}

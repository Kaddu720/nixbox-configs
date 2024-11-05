{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./xinitrc.nix
    ./polybar.nix
    ./picom.nix
    ./dmenu/dmenu.nix
    ./gtk-theme.nix
  ];

  config = lib.mkIf (config.services.desktop-config.linux.linuxUtils == true) {
    xinitrc.enable = true;
    polybar.enable = true;
    picom.enable = true;
    #dmenu.enable = true;
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

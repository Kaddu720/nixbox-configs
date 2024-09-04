{pkgs, ...}: {
  # Import nix modules

  home = {
    username = "noah";
    homeDirectory = "/home/noah";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Broswer opens thunar by default
  xdg.mimeApps.defaultApplications."inode/directory" = "thunar";

  # Install Packages
  home.packages = with pkgs; [
    bitwarden-desktop
    caffeine-ng
    discord
    dunst
    feh
    firefox
    flameshot
    font-awesome_5
    (nerdfonts.override {fonts = ["Hack"];})
    obsidian
    pavucontrol
    xautolock
    zoom-us
  ];
}

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
    discord
    firefox
    flameshot
    obsidian
    pavucontrol
    zoom-us
  ];

  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    linux = {
      dk = true;
      sxhkd = true;
      linuxUtils = true;
    };
  };
}

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

  # Use neovim from NixCats
  nvim.enable = true;

  # Install Packages
  home.packages = with pkgs; [
    discord
    firefox
    flameshot
    obsidian
    pavucontrol
    swaylock
    zoom-us
    river
  ];

  # Wayland

  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    linux = {
      dk = true;
      sxhkd = true;
      river = true;
      linuxUtils = true;
    };
  };
}

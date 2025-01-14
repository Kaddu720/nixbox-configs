{
  pkgs,
  inputs,
  ...
}: {
  # Import nix modules
  imports = [
    ../../static/stylix.nix
    ../../../home-manager/optional/applications/zen-browser.nix
  ];

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
    firefox
    flameshot
    obsidian
    pavucontrol
    swaylock
    zoom-us
    river
    wl-clipboard
    grimblast # wayland screenshots
    vesktop # linux discord client

    # flake  inputs
    inputs.zen-browser.packages."x86_64-linux".default
    inputs.ghostty.packages.x86_64-linux.default
  ];

  # Application Customization
  zen-browser.enable = true;

  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    linuxDesktop = true;
  };
}

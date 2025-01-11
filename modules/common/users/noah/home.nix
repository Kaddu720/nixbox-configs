{
  pkgs,
  ...
}: {
  # Import nix modules
  imports = [
    ../../static/stylix.nix
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
  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      firefox
      flameshot # work in xord
      obsidian
      pavucontrol
      swaylock
      zoom-us
      river
      wl-clipboard
      grimblast # wayland screenshots
      vesktop # linux discord client
      ;
  };

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

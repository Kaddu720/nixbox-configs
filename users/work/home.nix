{pkgs, ...}: {
  imports = [
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop
  ];

  # -------------------- User Configuration --------------------
  home = {
    username = "noahwilson";
    homeDirectory = "/Users/noahwilson";
  };

  # -------------------- Optional Modules --------------------
  fish.enable = true;
  nushell.enable = true;
  starship.enable = true;
  ghostty.enable = true;
  alacritty.enable = true;
  # Use neovim from NixCats
  nvim.enable = true;

  # -------------------- User Packages --------------------
  nixpkgs.config.allowUnfree = true;
  # Install Packages
  home.packages = with pkgs; [
    obsidian
    nerd-fonts.jetbrains-mono
  ];

  # -------------------- Desktop Services --------------------
  # Imported Optional Modules
  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };

  # -------------------- Git Configuration --------------------
  #disables personall git credentials
  git.enable = false;
}

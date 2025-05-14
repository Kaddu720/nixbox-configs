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
  devPkgs.enable = true;
  # Use neovim from NixCats
  nvim.enable = true;
  #disables personall git credentials
  git.enable = false;

  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };

  # -------------------- User Packages --------------------
  nixpkgs.config.allowUnfree = true;
  # Install Packages
  home.packages = with pkgs; [
    obsidian
    nerd-fonts.jetbrains-mono
  ];

  #enable programs and services
  programs.zoxide.enable = true;
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/Users/noahwilson/.config/nixos";
    };
  };
}

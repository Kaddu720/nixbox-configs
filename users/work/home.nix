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
    sessionVariables = {
      EDITOR = "nvim";
      HOME = "/Users/noahwilson";
      AWS_PROFILE = "sre_v1-prod";
      TF_SECRET = "terraform_builder";
      NH_DARWIN_FLAKE = "/Users/noahwilson/.nixos#darwinConfigurations.Work-Box";
      NH_HOME_FLAKE = "/Users/noahwilson/.nixos#noah@Work-Box";
    };
  };

  # -------------------- Optional Modules --------------------
  fish.enable = true;
  nushell.enable = true;
  ghostty.enable = true;
  alacritty.enable = true;
  devPkgs.enable = true;
  dev-ai.enable = true;
  dev-kubernetes.enable = true;
  dev-cloud.enable = true;
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
    slack
  ];

  #enable programs and services
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/Users/noahwilson/.nixos";
    };
  };
}

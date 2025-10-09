{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../users/work/home.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop
  ];

  # -------------------- Host-specific Configuration --------------------
  
  # Home directory
  home.homeDirectory = "/Users/noahwilson";
  
  # Host-specific session variables
  home.sessionVariables = {
    HOME = "/Users/noahwilson";
    AWS_PROFILE = "sre_v1-prod";
    TF_SECRET = "terraform_builder";
    NH_DARWIN_FLAKE = "/Users/noahwilson/.nixos#darwinConfigurations.Work-Box";
    NH_HOME_FLAKE = "/Users/noahwilson/.nixos#noah@Work-Box";
  };
  
  # SSH configuration
  ssh.githubIdentityFile = "~/.ssh/work-box";
  
  # Terminal font size (Mac = larger font)
  ghostty.fontSize = 18;
  alacritty.fontSize = 18;
  
  # Mac-specific dev tools
  dev-ai.enable = true;
  
  # Host-specific packages
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
  
  # Host-specific sesh sessions
  sesh.sessions = lib.mkAfter [
    {
      name = "Work_Brain";
      path = "~/Vaults/Work_Brain/";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
    {
      name = "axs-configurations";
      path = "~/Documents/sre_lambda_layer/GitHub/axs-configurations";
      startupCommand = "nvim && tmux new-window lazygit";
    }
  ];
  
  # nh configuration
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/Users/noahwilson/.nixos";
  };
  
  # Services
  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # State version
  home.stateVersion = "23.11";
}


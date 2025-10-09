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
  
  home.homeDirectory = "/Users/noahwilson";
  
  home.sessionVariables = {
    HOME = "/Users/noahwilson";
    AWS_PROFILE = "sre_v1-prod";
    TF_SECRET = "terraform_builder";
    NH_DARWIN_FLAKE = "/Users/noahwilson/.nixos#darwinConfigurations.Work-Box";
    NH_HOME_FLAKE = "/Users/noahwilson/.nixos#noah@Work-Box";
  };
  
  ssh.githubIdentityFile = "~/.ssh/work-box";

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/Users/noahwilson/.nixos";
  };
  
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  services.desktop-config = {
    enable = true;
    macDesktop = true;
  };
  
  ghostty.fontSize = 18;
  alacritty.fontSize = 18;
  
  dev-ai.enable = true;
  
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
  
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}


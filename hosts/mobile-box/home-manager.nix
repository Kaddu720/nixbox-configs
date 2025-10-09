{
  lib,
  ...
}: {
  imports = [
    ../../users/noah/home.nix
    ../../users/noah/linux.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop
    ../../modules/common/static/stylix.nix
  ];

  # -------------------- Host-specific Configuration --------------------
  
  home.homeDirectory = "/home/noah";
  
  home.sessionVariables = {
    HOME = "/home/noah";
  };
  
  ssh.githubIdentityFile = "~/.ssh/mobile/mobile";

  programs.nh.flake = "/home/noah/.nixos";
  
  services.desktop-config.enable = true;
  
  ghostty.fontSize = 14;
  alacritty.fontSize = 14;
  
  sesh.sessions = lib.mkAfter [
    {
      name = "Second_Brain";
      path = "~/Vaults/Second_Brain";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
  ];
}


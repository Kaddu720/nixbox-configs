{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../../users/noah/home.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop
    ../../modules/common/static/stylix.nix
  ];

  # -------------------- Host-specific Configuration --------------------
  
  home.homeDirectory = "/home/noah";
  
  home.sessionVariables = {
    HOME = "/home/noah";
    TERMINAL = "ghostty";
    XDG_SESSION_TYPE = "wayland";
  };
  
  ssh.githubIdentityFile = "~/.ssh/mobile/mobile";

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/noah/.nixos";
  };
  
  home.packages = with pkgs; [
    # System Tools
    kooha
    pavucontrol
    swaylock
    tree
    wl-clipboard
    grimblast
    # Applications
    onlyoffice-desktopeditors
    river-classic
    presenterm
    vlc
    zoom-us
    # Flake inputs
    inputs.zen-browser.packages."x86_64-linux".default
    inputs.ghostty.packages.x86_64-linux.default
  ];

  services = {
    desktop-config = {
      enable = true;
      linuxDesktop = true;
    };
    ssh-agent.enable = true;
  };
  
  ghostty.fontSize = 14;
  alacritty.fontSize = 14;
  
  dev-containers.enable = true;
  
  sesh.sessions = lib.mkAfter [
    {
      name = "Second_Brain";
      path = "~/Vaults/Second_Brain";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
  ];
  
  programs.bash.enable = true;
  
  xdg.desktopEntries = {
    "discord-wayland" = {
      name = "Discord (Wayland)";
      comment = "Chat client with native Wayland support";
      exec = "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland";
      icon = "discord";
      terminal = false;
      categories = ["Network" "InstantMessaging"];
    };
    "zoom-wayland" = {
      name = "Zoom (Wayland)";
      comment = "Video conferencing with Wayland support";
      exec = "${pkgs.zoom-us}/bin/zoom-us --enable-features=UseOzonePlatform --ozone-platform=wayland";
      icon = "zoom";
      terminal = false;
      categories = ["Network" "VideoConference"];
    };
  };
  
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";
  };
  
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}


{
  pkgs,
  inputs,
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
  
  # Home directory
  home.homeDirectory = "/home/noah";
  
  # Host-specific session variables
  home.sessionVariables = {
    HOME = "/home/noah";
    TERMINAL = "ghostty";
    XDG_SESSION_TYPE = "wayland";
  };
  
  # SSH configuration
  ssh.githubIdentityFile = "~/.ssh/mobile/mobile";
  
  # Terminal font size (laptop = larger font)
  ghostty.fontSize = 14;
  alacritty.fontSize = 14;
  
  # Linux-specific dev tools
  dev-containers.enable = true;
  
  # Host-specific packages
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
  
  # Host-specific sesh sessions
  sesh.sessions = sesh.sessions ++ [
    {
      name = "Second_Brain";
      path = "~/Vaults/Second_Brain";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
  ];
  
  # nh configuration
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/noah/.nixos";
  };
  
  programs.bash.enable = true;
  
  # Wayland desktop entries
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
  
  # XDG configuration
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";
  };
  
  # Services
  services = {
    desktop-config = {
      enable = true;
      linuxDesktop = true;
    };
    ssh-agent.enable = true;
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # State version
  home.stateVersion = "23.11";
}


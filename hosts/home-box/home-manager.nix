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
  
  # Home directory (home-manager native)
  home.homeDirectory = "/home/noah";
  
  # Host-specific session variables (home-manager native)
  home.sessionVariables = {
    HOME = "/home/noah";
    TERMINAL = "ghostty";
    XDG_SESSION_TYPE = "wayland";
  };
  
  # SSH configuration (custom module option)
  ssh.githubIdentityFile = "~/.ssh/personal/personal";
  
  # Terminal font size (custom module options)
  ghostty.fontSize = 12;
  alacritty.fontSize = 12;
  
  # Linux-specific dev tools (custom module option)
  dev-containers.enable = true;
  
  # Host-specific packages (home-manager native)
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
  
  # Host-specific sesh sessions (custom module option)
  sesh.sessions = sesh.sessions ++ [
    {
      name = "Second_Brain";
      path = "~/Vaults/Second_Brain";
      startupCommand = "nvim . && tmux new-window lazygit";
    }
    {
      name = "ekiree_dashboard";
      path = "~/Projects/dashboard/dev/ekiree_dashboard";
      startupCommand = "tmuxp load -a ekiree_dashboard && tmux split-window -h -l 30% && nvim && tmux new-window lazygit";
    }
  ];
  
  # Tmuxp layouts (custom module option)
  sesh.tmuxpLayouts = {
    ekiree_dashboard = ''
      session_name: ekiree_dashboard

      windows:
      - window_name: term
        layout: main-vertical
        shell_command_before:
          - cd ekiree_dashboard
        panes:
          - shell_command:
            - clear
            focus: true
          - shell_command:
            - clear
            - python manage.py runserver

      - window_name: git
        panes:
          - shell_command:
            - lazygit
    '';
  };
  
  # nh configuration (home-manager native)
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/noah/.nixos";
  };
  
  programs.bash.enable = true; # (home-manager native)
  
  # Wayland desktop entries (home-manager native)
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
  
  # XDG configuration (home-manager native)
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";
  };
  
  # Services
  services = {
    desktop-config = { # (custom module option)
      enable = true;
      linuxDesktop = true;
    };
    ssh-agent.enable = true; # (home-manager native)
  };
  
  # Let Home Manager install and manage itself (home-manager native)
  programs.home-manager.enable = true;

  # State version (home-manager native)
  home.stateVersion = "23.11";
}


{
  pkgs,
  inputs,
  ...
}: {
  # -------------------- Imports --------------------
  imports = [
    ../../modules/home-manager/core
    ../../modules/home-manager/optional
    ../../modules/home-manager/optional/desktop
    ../../modules/home-manager/optional/zen-browser.nix
  ];

  # -------------------- Home Manager Configuration --------------------
  # Enable home-manager itself
  programs.home-manager.enable = true;

  # -------------------- Optional Modules --------------------
  fish.enable = true;
  nushell.enable = true;
  ghostty = {
    enable = true;
    fontSize = 12;
  };
  alacritty = {
    enable = true;
    fontSize = 12;
  };
  devPkgs.enable = true;
  dev-containers.enable = true;
  dev-kubernetes.enable = true;
  dev-cloud.enable = true;
  # Use neovim from NixCats
  nvim.enable = true;

  # Sesh sessions
  sesh = {
    enable = true;
    sessions = [
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
      {
        name = "nixos";
        path = "~/.nixos";
        startupCommand = "tmux split-window -h -l 30% && nvim && tmux new-window lazygit";
      }
      {
        name = "nvim-dev";
        path = "~/.config/nvim";
        startupCommand = "nvim && tmux new-window lazygit";
      }
    ];
    tmuxpLayouts = {
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
  };

  # -------------------- Nixpkgs Configuration --------------------
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
  # -------------------- User Configuration --------------------
  home = {
    username = "noah";
    homeDirectory = "/home/noah";
    # User session variables
    sessionVariables = {
      EDITOR = "nvim";
      HOME = "/home/noah";
      TERMINAL = "ghostty";
      XDG_SESSION_TYPE = "wayland";
    };
    packages = with pkgs; [
      # System Tools
      kooha
      pavucontrol
      swaylock
      tree
      wl-clipboard
      grimblast # Wayland Screenshots
      # Applications
      obsidian
      onlyoffice-desktopeditors
      river-classic
      presenterm
      vlc
      zoom-us
      # Flake inputs
      inputs.zen-browser.packages."x86_64-linux".default
      inputs.ghostty.packages.x86_64-linux.default
    ];
    # This is required for home-manager to work properly
    stateVersion = "23.11"; # Use the appropriate version
  };
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/noah/.nixos";
    };
    # SSH Configuration
    ssh = {
      enable = true;
    };
    # Add other programs
    bash.enable = true; # Configure bash if you use it
  };

  # -------------------- Forcing X11 applications to work --------------------

  # Do the same for Zoom if you use it
  xdg.desktopEntries = {
    "discord-wayland" = {
      # This is the name you will see in your application launcher
      name = "Discord (Wayland)";
      comment = "Chat client with native Wayland support";

      # This is the command that will be executed, with our magic flags
      exec = "${pkgs.discord}/bin/discord --enable-features=UseOzonePlatform --ozone-platform=wayland";

      # Standard metadata for the application entry
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

  # -------------------- XDG Configuration --------------------
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar"; # Open directories with Thunar by default
  };

  # -------------------- User Services --------------------
  services = {
    # Desktop configuration
    desktop-config = {
      enable = true;
      linuxDesktop = true;
    };
    # SSH agent service (user level)
    ssh-agent.enable = true;
  };
}

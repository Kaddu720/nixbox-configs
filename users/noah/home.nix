# ~/.config/home-manager/noah.nix
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
  ghostty.enable = true;
  alacritty.enable = true;
  devPkgs.enable = true;
  # Use neovim from NixCats
  nvim.enable = true;

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
    # Package installations
    packages = with pkgs; [
      # System Tools
      kooha
      pavucontrol
      swaylock
      wl-clipboard
      grimblast # Wayland screenshots
      # Applications
      obsidian
      river
      presenterm
      # Flake inputs
      inputs.zen-browser.packages."x86_64-linux".default

      # inputs.ghostty.packages.x86_64-linux.default
      # Temp Ghostty wrapper with Wayland fix + fallback
      (pkgs.writeShellScriptBin "ghostty" ''
        #!/usr/bin/env bash
        # Force Mesa/GBM to use the AMD GPU (card1)
        export DRM_DEVICE=/dev/dri/card1

        # Try native Wayland first
        if ! ${inputs.ghostty.packages.x86_64-linux.default}/bin/ghostty "$@" 2>/dev/null; then
          echo "Wayland EGL failed — falling back to XWayland + Cairo"
          export GDK_BACKEND=x11
          export GSK_RENDERER=cairo
          export GDK_GL=disable
          export GDK_DISABLE=gles-api,vulkan
          exec ${inputs.ghostty.packages.x86_64-linux.default}/bin/ghostty "$@"
        fi
      '')
    ];
    # This is required for home-manager to work properly
    stateVersion = "23.11"; # Use the appropriate version
  };
  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/noah/.config/nixos";
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

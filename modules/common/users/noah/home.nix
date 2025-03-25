# ~/.config/home-manager/noah.nix
{
  pkgs,
  inputs,
  ...
}: {
  # -------------------- Imports --------------------
  imports = [
    ../../static/stylix.nix
    ../../../home-manager/optional/applications/zen-browser.nix
  ];

  # -------------------- Home Manager Configuration --------------------
  # Enable home-manager itself
  programs.home-manager.enable = true;

  # -------------------- User Configuration --------------------
  home = {
    username = "noah";
    homeDirectory = "/home/noah";
    
    # User session variables
    sessionVariables = {
      EDITOR = "nvim";
      HOME = "/home/noah";
      TERMINAL = "alacritty";
    };
    
    # Package installations
    packages = with pkgs; [
      # Browsers & Communication
      firefox
      zoom-us
      vesktop # Discord client
      
      # System Tools
      flameshot
      pavucontrol
      swaylock
      wl-clipboard
      grimblast # Wayland screenshots
      
      # Applications
      obsidian
      river
      
      # Flake inputs
      inputs.zen-browser.packages."x86_64-linux".default
      inputs.ghostty.packages.x86_64-linux.default
    ];
    
    # This is required for home-manager to work properly
    stateVersion = "23.11"; # Use the appropriate version
  };
  
  # -------------------- Nixpkgs Configuration --------------------
  nixpkgs.config = {
    allowUnfree = true;
  };
  
  # -------------------- XDG Configuration --------------------
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = "thunar";  # Open directories with Thunar by default
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
    
    # Optional: MySQL service if you want it user-level instead of system-level
    # Note: For database services, system-level is usually preferred
    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    #   dataDir = "${config.home.homeDirectory}/.local/share/mysql";
    # };
  };
  
  # -------------------- User Programs --------------------
  # Neovim from NixCats
  nvim.enable = true;

  programs = {
    
    # SSH Configuration
    ssh = {
      enable = true;
      # Add SSH configuration as needed
      # matchBlocks = { ... };
    };
    
    # Add other programs
    bash.enable = true;  # Configure bash if you use it
    
    # Add any GUI applications that should be configured
    firefox = {
      enable = true;
      # Add Firefox configuration as needed
    };
  };
}

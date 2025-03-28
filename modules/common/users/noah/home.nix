# ~/.config/home-manager/noah.nix
{
  pkgs,
  inputs,
  ...
}: {
  # -------------------- Imports --------------------
  imports = [
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
      TERMINAL = "ghostty";
    };
    
    # Package installations
    packages = with pkgs; [
      # Browsers & Communication
      zoom-us
      discord
      
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
  };
}

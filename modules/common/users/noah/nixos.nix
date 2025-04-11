{
  pkgs,
  ...
}: {
  # -------------------- User Accounts --------------------
  users.users.noah = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"]; # Enable 'sudo' for the user
    group = "users";
    createHome = true;
    home = "/home/noah";
    uid = 1000;
    
    # System-level packages (prefer moving user-specific packages to home-manager)
    packages = with pkgs; [
      # beekeeper-studio
      bluez
      dislocker
      home-manager
      libreoffice-still
      rtkit
      tree
      wirelesstools
      xdg-desktop-portal-wlr # enable screen sharing for river wm
    ];
  };

  # -------------------- System Configuration for Home Manager --------------------
  # No direct home-manager integration - running standalone
  # These settings ensure the system supports the standalone home-manager

  # -------------------- Security Configuration --------------------
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # -------------------- XDG Portal Configuration --------------------
  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    
    # Define which portal implementations to use
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr  # For Wayland compositors like river
      xdg-desktop-portal-gtk  # For better integration with GTK apps
    ];
    
    # Configure portal backends by desktop environment
    config = {
      river = {
        default = [
          "wlr"
          "gtk"
        ];
        # Set preferred backends for specific portals
        screencast = "wlr";
        screenshot = "wlr";
      };
    };
    
    # WLR-specific settings
    wlr = {
      enable = true;
      settings = {
        screencast = {
          output_name = "DP-1";
          max_fps = 30;
          chooser_type = "simple";
          # Use slurp for area selection if needed
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
        
        # Add screenshot settings
        screenshot = {
          choose_type = "slurp";  # Use slurp for selection
        };
      };
    };
  };
  
  # Enable additional dependencies for better portal functionality
  programs.xwayland.enable = true;  # For X11 app compatibility

  # -------------------- System Services --------------------
  # These services run at the system level and are available to all users
  services = {
    # Services that should remain system-wide
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
    # Enable locate for system-wide file indexing
    locate.enable = true;
    # Enable SSH server (not the client)
    openssh = {
      enable = true;
    };
  };

  # -------------------- System Programs --------------------
  programs = {
    dconf.enable = true; # enable gtk desktops
    ssh = {
      startAgent = true;
      askPassword = "";
    };
  };
}

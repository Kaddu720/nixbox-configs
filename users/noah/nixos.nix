{pkgs, ...}: {
  # -------------------- User Accounts --------------------
  users.users.noah = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker" "corectrl" "video" "render"]; # Enable 'sudo' for the user
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
      onlyoffice-desktopeditors
      rtkit
      tree
      vlc
      wirelesstools
      zoom-us
    ];
  };

  services.xserver.videoDrivers = ["amdgpu"];
  hardware.graphics = {
    enable = true; # Enables GPU acceleration
    enable32Bit = true; # Needed for 32-bit apps (e.g., Steam, Wine)
  };

  programs = {
    sway.enable = true; # Sets up screenshaing infra used by river
    dconf.enable = true; # enable gtk desktops
    ssh = {
      startAgent = true;
      askPassword = "";
    };
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

  # Enable additional dependencies for better portal functionality
  programs.xwayland.enable = true; # For X11 app compatibility

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
}

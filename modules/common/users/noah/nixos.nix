{
  inputs,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noah = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager" "docker"]; # Enable ‘sudo’ for the user.
    group = "users";
    createHome = true;
    home = "/home/noah";
    uid = 1000;
  };

  # Configure Environment
  environment = {
    # List packages at system level
    systemPackages = with pkgs; [
      beekeeper-studio
      bluez
      dislocker
      libreoffice-still
      rtkit
      tree
      wirelesstools
      inputs.zen-browser.packages."x86_64-linux".default
    ];
    variables = {
      EDITOR = "nvim";
      HOME = "/home/noah";
    };
  };

  # Enable river wm
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };
  services.dbus.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
    wlr = {
      enable = true;
      settings = {
        # uninteresting for this problem, for completeness only
        screencast = {
          output_name = "DP-1";
          max_fps = 30;
          chooser_type = "simple";
          # chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };

  #Configure Services
  services = {
    mysql = {
      enable = true;
      package = pkgs.mariadb;
    };

    # Enable users to use system programs
    locate.enable = true;

    # Enable SSH
    openssh = {
      enable = true;
    };
  };

  #Configure Programs
  programs = {
    slock.enable = true;
    dconf.enable = true; #enable gtk desktops
    ssh = {
      startAgent = true;
      askPassword = "";
    };
  };
}

{
  inputs,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.noah = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    group = "users";
    createHome = true;
    home = "/home/noah";
    uid = 1000;
  };

  # Configure Environment
  environment = {
    # List packages at system level
    systemPackages = with pkgs; [
      bluez
      bottles
      dk
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

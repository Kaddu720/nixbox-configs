{ pkgs, ... }: {
    imports = [
        ../../../nixos/default.nix
    ];

    networking.networkmanager.enable = true;

    time = {
        # Set your time zone.
        timeZone = "America/Los_Angeles";
    
        # Allow windows to have correct time on dual boot
        hardwareClockInLocalTime = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    # Enable experimental packages
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    # Configure Environment
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            dislocker
            killall
            mangohud
            neovim
            wget
        ];
    };

    # Enable automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    # This option defines the first version of NixOS you have installed on this particular machine,
    system.stateVersion = "23.11"; # Did you read the comment?
}

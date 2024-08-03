{ pkgs, ... }: {

    imports = [ # Include the results of the hardware scan.
    ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #users
    users.users.noahwilson = {
        home = "/Users/noahwilson";
    };

    security.pam.enableSudoTouchIdAuth = true;

    system= {
        defaults = {
            dock = {
                autohide = true;
                mru-spaces = false;
            };
           finder = {
               AppleShowAllExtensions = true;
               CreateDesktop = false;
               FXPreferredViewStyle = "Nlsv";
            };

            NSGlobalDomain.AppleInterfaceStyle = "Dark";
            screensaver.askForPasswordDelay = 10;
            spaces.spans-displays = false;
        };
        keyboard = {
            enableKeyMapping = true;
            remapCapsLockToControl = true;
            swapLeftCommandAndLeftAlt = true;
        };
    };

    #Configure Environmental Variables
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            sketchybar-app-font
            slack
            #redisinsight
        ];
        variables = { 
            EDITOR = "nvim"; 
            HOME = "/Users/noahwilson";
            Host = "aarch65-darwin";
        };
    };
    
    #enable programs as services
    services = {
        skhd.enable = true;
        sketchybar.enable = true;
    };

    # Enable home-brew (remember to go to the homebrew website and install it)
    # fish is already configured to use it
    homebrew= {
        enable = true;
        casks = [
            "amethyst"
        ];
    };

    nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = "noahwilson";
        autoMigrate = true;
    };

    # Enable automatic garbage collection
    nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;
}

{ pkgs, ... }: {

    imports = [ # Include the results of the hardware scan.
        ../../modules/darwin/mac-desktop.nix
    ];

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    #users
    users.users.noahwilson = {
        home = "/Users/noahwilson";
    };

    #Configure Environmental Variables
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            home-manager
            neovim
        ];
        variables = { 
            EDITOR = "nvim"; 
            HOME = "/Users/noahwilson";
        };
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

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

    #Configure Environmental Variables
    environment = {
        # List packages at system level
        systemPackages = with pkgs; [
            neovim
            sketchybar
            sketchybar-app-font
            yabai
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
        yabai.enable = true;
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

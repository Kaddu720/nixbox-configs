{ pkgs, inputs, ... }: {

    # Auto upgrade nix package and the daemon service.
    services.nix-daemon.enable = true;
    # nix.package = pkgs.nix;

    # Necessary for using flakes on this system.
    nix.settings.experimental-features = "nix-command flakes";

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";

    users.users.noahwilson = {
        home = "/Users/noahwilson";
    };

    home-manager = {
        #also pas inputs to home-manager modules
        extraSpecialArgs = { inherit inputs; };
        users = {
            "noahwilson" = import ../home-manager/work-home.nix;
        };
    };

    # List packages at system level
    environment.systemPackages = with pkgs; [
        neovim
    ];

    # Enable Programs
    programs.fish.enable = true;

    environment.variables = { 
        EDITOR = "nvim"; 
        HOME = "/Users/noahwilson";
    };

    # Enable automatic garbage collection
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 4;
}

{ pkgs, ... }: {
    home = {
        username = "noahwilson";
        homeDirectory = "/Users/noahwilson";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Import nix modules
    imports = [
        ../modules/home-manager/mac/default.nix
        ../modules/home-manager/dev-modules/default.nix
    ];

    #disables personall git credentials
    git.enable = false;

    # Install Packages
    home.packages = with pkgs; [
        flameshot
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Origial nix version this was configured on
    # Dont' delete or it could bork the entire config
    home.stateVersion = "23.11";
}

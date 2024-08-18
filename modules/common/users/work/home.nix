{ pkgs, ... }: {
    # Import nix modules
    imports = [
        ../../../home-manager/mac-desktop
        ../../../home-manager/dev-modules
    ];

    home = {
        username = "noahwilson";
        homeDirectory = "/Users/noahwilson";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    #disables personall git credentials
    git.enable = false;

    # Install Packages
    home.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "Hack" ]; })
        (python311.withPackages (ppkgs: [
            ppkgs.boto3
        ]))
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Origial nix version this was configured on
    # Dont' delete or it could bork the entire config
    home.stateVersion = "23.11";
}

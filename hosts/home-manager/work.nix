{ pkgs, inputs, ... }: {
    home.username = "noahwilson";
    home.homeDirectory = "/Users/noahwilson";

    home.stateVersion = "23.11"; # Origial nix version this was configured on

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Import nix modules
    imports = [
        ../../modules/home-manager/dev-modules.nix
        inputs.nixvim.homeManagerModules.nixvim
    ];

    # Install Packages
    home.packages = with pkgs; [
        flameshot
        (nerdfonts.override { fonts = [ "Hack" ]; })
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

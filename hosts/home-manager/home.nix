{ pkgs, inputs, ... }: {
    home.username = "noah";
    home.homeDirectory = "/home/noah";

    home.stateVersion = "23.11"; # Origial nix version this was configured on

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Import nix modules
    imports = [
        ../../modules/home-manager/modules.nix
        ../../modules/home-manager/dev-modules.nix
        inputs.nixvim.homeManagerModules.nixvim
    ];

    # Desktop Environment
    dwlinit.enable    = true;
    dwl.enable        = true;
    dmenu.enable      = true;
    pywal.enable      = true;
    gtk-tools.enable  = true;

    # Install Packages
    home.packages = with pkgs; [
        caffeine-ng
        discord
        dunst
        feh
        firefox
        flameshot
        font-awesome_5
        neofetch
        (nerdfonts.override { fonts = [ "Hack" ]; })
        obsidian
        pipewire_0_2
        pavucontrol
        syncthing
        ventoy-full
        xautolock
        zoom-us
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

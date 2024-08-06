{ config, pkgs, inputs, ... }: {
    # Import nix modules
    imports = [
        ../../../home-manager/linux-desktop/default.nix
        ../../../home-manager/dev-modules/default.nix
    ];

    home = {
        username = "noah";
        homeDirectory = "/home/noah";
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;


    # Broswer opens thunar by default
    xdg.mimeApps.defaultApplications."inode/directory" = "thunar";

    # Install Packages
    home.packages = with pkgs; [
        caffeine-ng
        discord
        dunst
        feh
        firefox
        flameshot
        font-awesome_5
        (nerdfonts.override { fonts = [ "Hack" ]; })
        obsidian
        pavucontrol
        xautolock
        zoom-us
    ];

    # configure services
    services = {
        syncthing.enable = true;
    };

    programs.ssh = {
        enable = true;
        addKeysToAgent = "yes";
        matchBlocks = {
            "github.com" = {
                user = "git";
                identityFile = "~/.ssh/personal/personal";
            };
        };
    };
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    # Origial nix version this was configured on
    # Dont' delete or it could bork the entire config
    home.stateVersion = "23.11";
}

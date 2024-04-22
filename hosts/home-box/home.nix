{ config, pkgs, inputs, ... }: {
    home.username = "noah";
    home.homeDirectory = "/home/noah";

    home.stateVersion = "23.11"; # Origial nix version this was configured on

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Import nix modules
    imports = [
        ../../modules/home-manager/modules.nix
    ];

    # Desktop Environment
    xinitrc.enable   = true;
    dwm.enable       = true;
    picom.enable     = true;
    pywal.enable     = true;
    dwmblocks.enable = true;
    dmenu.enable     = true;
    thunar.enable    = true;

    # Development Tools
    fish.enable      = true;
    alacirtty.enable = true;
    neovim.enable    = true;
    tmux.enable      = true;

    # Install Packages
    home.packages = with pkgs; [
        caffeine-ng
        discord
        feh
        firefox
        flameshot
        font-awesome_5
        hack-font
        lazygit
        neofetch
        obsidian
        pipewire_0_2
        pwvucontrol
        syncthing
        vscodium
        xautolock
    ];

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}

{ pkgs, lib, ... }: {
    imports = [
        ./fish.nix
        ./alacritty.nix
        ./nixvim.nix
        ./tmux.nix
        ./git.nix
    ];

    fish.enable = 
        lib.mkDefault true;
    alacritty.enable =
        lib.mkDefault true;
    nixvim.enable =
        lib.mkDefault true;
    tmux.enable =
        lib.mkDefault true;
    git.enable = 
        lib.mkDefault true;

    home.packages = with pkgs; [
        awscli2
        bat
        bottom
        fzf
        htop
        jq
        lazygit
        nerdfonts
        ripgrep
        sops
        thefuck
        vscodium
        zoxide
    ];
}

{ pkgs, lib, ... }: {
    imports = [
        ./fish/fish.nix
        ./alacirtty.nix
        ./nixvim.nix
        ./tmux.nix
    ];

    fish.enable = 
        lib.mkDefault true;
    alacirtty.enable =
        lib.mkDefault true;
    nixvim.enable =
        lib.mkDefault true;
    tmux.enable =
        lib.mkDefault true;

    home.packages = with pkgs; [
        awscli2
        bat
        fzf
        lazygit
        nerdfonts
        ripgrep
        thefuck
        vscodium
        zoxide
    ];
}

{ pkgs, lib, ... }: {
    imports = [
        ./fish/fish.nix
        ./alacirtty.nix
        ./neovim.nix
        ./tmux.nix
    ];

    fish.enable = 
        lib.mkDefault true;
    alacirtty.enable =
        lib.mkDefault true;
    neovim.enable =
        lib.mkDefault true;
    tmux.enable =
        lib.mkDefault true;


    home.packages = with pkgs; [
        awscli2
        bat
        fzf
        lazygit
        thefuck
        vscodium
        zoxide
    ];
}

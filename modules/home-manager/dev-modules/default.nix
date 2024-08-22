{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./alacritty.nix
    ./tmux.nix
    ./git.nix
    ./neovim/nixvim.nix
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
    bat
    bottom
    fzf
    jq
    lazygit
    nerdfonts
    ripgrep
    sops
    thefuck
    zoxide
    # AXS / Ekiree managment modules
    awscli2
    terraform
  ];
}

{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./neovim/nixvim.nix
  ];

  alacritty.enable =
    lib.mkDefault true;
  nixvim.enable =
    lib.mkDefault true;
  tmux.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    bat
    jq
    lazygit
    nerdfonts
    # AXS / Ekiree managment modules
    awscli2
    terraform
  ];
}

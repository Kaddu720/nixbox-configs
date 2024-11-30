{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./neovim/nixvim.nix
    ./fish.nix
    ./nushell.nix
    ./starship.nix
  ];

  alacritty.enable =
    lib.mkDefault true;
  nixvim.enable =
    lib.mkDefault true;
  tmux.enable =
    lib.mkDefault true;
  fish.enable =
    lib.mkDefault true;
  nushell.enable =
    lib.mkDefault true;
  starship.enable =
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

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    carapace.enable = true;
  };
}

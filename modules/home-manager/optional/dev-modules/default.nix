{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./fish.nix
    ./ghostty.nix
    ./nushell.nix
    ./starship.nix
  ];

  alacritty.enable =
    lib.mkDefault true;
  tmux.enable =
    lib.mkDefault true;
  fish.enable =
    lib.mkDefault true;
  ghostty.enable =
    lib.mkDefault true;
  nushell.enable =
    lib.mkDefault true;
  starship.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    bat
    lazygit
    lazydocker
    jq
    yazi
    # AXS / Ekiree managment modules
    awscli2
    docker
    kubectl
    k9s
    terraform
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
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

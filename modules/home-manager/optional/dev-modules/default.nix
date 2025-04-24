{
  lib,
  pkgs,
  vars,
  ...
}: let
  # Optional packages for mac or linux
  platformPackages =
    if "${vars.hostName}" == "Work-Box"
    then with pkgs; [opentofu lens]
    else with pkgs; [docker podman lazydocker];
in {
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

  home.packages = with pkgs;
    [
      lazygit
      jq
      nerd-fonts.jetbrains-mono
      awscli2
      kubectl
      k9s
      terraform
    ]
    ++ platformPackages;

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    carapace.enable = true;
  };
}

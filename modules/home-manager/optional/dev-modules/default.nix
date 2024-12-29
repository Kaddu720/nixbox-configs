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
    ./lazygit.nix
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
  lazygit.enable =
    lib.mkDefault true;

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      bat
      jq
      # AXS / Ekiree managment modules
      # awscli2
      docker
      terraform
      ;
    inherit
      (pkgs.nerd-fonts)
      hack
      jetbrains-mono
      ;
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    carapace.enable = true;
  };
}

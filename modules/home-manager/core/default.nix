
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./fish.nix
    ./git.nix
  ];

  fish.enable =
    lib.mkDefault true;
  git.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    bottom
    fzf
    ripgrep
    sops
    thefuck
    zoxide
  ];
}

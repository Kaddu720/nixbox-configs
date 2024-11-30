
{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
  ];

  git.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    bottom
    fzf
    ripgrep
    sops
  ];

  programs = {
    thefuck.enable = true;
    zoxide.enable = true;
  };
}

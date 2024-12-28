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

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
      btop
      fzf
      ripgrep
      sops
      ;
  };

  programs = {
    thefuck.enable = true;
    zoxide.enable = true;
  };
}

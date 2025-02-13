{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./btop.nix
  ];

  git.enable =
    lib.mkDefault true;
  btop.enable = 
    lib.mkDefault true;

  home.packages = builtins.attrValues {
    inherit
      (pkgs)
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

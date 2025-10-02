{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./btop.nix
    ./ssh.nix
    ./tmux.nix
    ./sesh.nix
  ];

  git.enable =
    lib.mkDefault true;
  btop.enable =
    lib.mkDefault true;
  ssh.enable =
    lib.mkDefault true;
  tmux.enable =
    lib.mkDefault true;
  sesh.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    bat
    fzf
    ripgrep
    sops
  ];
}

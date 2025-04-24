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
  ];

  git.enable =
    lib.mkDefault true;
  btop.enable =
    lib.mkDefault true;
  ssh.enable =
    lib.mkDefault true;
  tmux.enable =
    lib.mkDefault true;

  home.packages = with pkgs; [
    fzf
    ripgrep
    sops
  ];
}

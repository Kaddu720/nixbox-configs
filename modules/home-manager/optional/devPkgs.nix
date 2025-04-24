{
  pkgs,
  vars,
  ...
}: let
  # Optional packages for mac or linux
  platformPackages =
    if "${vars.hostName}" == "Work-Box"
    then with pkgs; [opentofu lens]
    else with pkgs; [docker lazydocker];
in {
  home.packages = with pkgs;
    [
      podman
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
    thefuck.enable = true;
  };
}

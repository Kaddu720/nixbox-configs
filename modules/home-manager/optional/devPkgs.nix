{
  pkgs,
  vars,
  lib,
  config,
  ...
}: let
  # Optional packages for mac or linux
  platformPackages =
    if "${vars.hostName}" == "Work-Box"
    then with pkgs; [terraform lens warp-terminal]
    else with pkgs; [docker lazydocker];
in {
  options = {
    devPkgs.enable =
      lib.mkEnableOption "enables development packages";
  };

  config = lib.mkIf config.devPkgs.enable {
    home.packages = with pkgs;
      [
        podman
        lazygit
        jq
        nerd-fonts.jetbrains-mono
        awscli2
        kubectl
        kubectx
        k9s
        opentofu
      ]
      ++ platformPackages;

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}

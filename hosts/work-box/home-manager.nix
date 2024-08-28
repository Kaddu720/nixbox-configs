{...}: {
  imports = [
    ../../modules/common/users/work/home.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional/mac-desktop
    ../../modules/home-manager/optional/dev-modules
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Origial nix version this was configured on
  # Dont' delete or it could bork the entire config
  home.stateVersion = "23.11";
}

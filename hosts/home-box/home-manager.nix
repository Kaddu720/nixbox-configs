{...}: {
  imports = [
    ../../users/noah/home.nix
    ../../modules/home-manager/core
    ../../modules/home-manager/optional/desktop
    ../../modules/home-manager/optional
    ../../modules/common/static/stylix.nix
  ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  games.enable = true;

  # Origial nix version this was configured on
  # Dont' delete or it could bork the entire config
  home.stateVersion = "23.11";
}

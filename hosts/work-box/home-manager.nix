{...}: {
  imports = [
    ../../users/work/home.nix
    ../../modules/common/static/stylix.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Optional Modules

  # Origial nix version this was configured on
  # Dont' delete or it could bork the entire config
  home.stateVersion = "23.11";
}

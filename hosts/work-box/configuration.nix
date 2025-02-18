{...}: {
  imports = [
    ../../modules/common/users/work/nixos.nix
    ../../modules/darwin
  ];

  # Necessary for using determinate nix
  nix.enable = false;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Imported Optional Modules

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

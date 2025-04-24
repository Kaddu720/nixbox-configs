{...}: {
  imports = [
    ../../users/work/nixos.nix
    ../../modules/darwin
  ];

  # Necessary for using determinate nix
  nix.enable = false;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}

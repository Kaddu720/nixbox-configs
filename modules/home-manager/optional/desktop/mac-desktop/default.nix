{
  config,
  lib,
  ...
}: {
  imports = [
    ./aerospace.nix
  ];

  config = lib.mkIf (config.services.desktop-config.macDesktop == true) {
    aerospace.enable = true;
  };
}

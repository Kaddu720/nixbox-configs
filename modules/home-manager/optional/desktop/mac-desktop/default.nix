{
  config,
  lib,
  pkgs,
  ...
}:
let
  wallpaper = builtins.path {
    path = ../../../../common/static/dark_fractal.jpg;
    name = "dark_fractal.jpg";
  };
in
{
  imports = [
    ./aerospace.nix
  ];

  config = lib.mkIf (config.services.desktop-config.macDesktop == true) {
    aerospace.enable = true;
    
    # Set wallpaper
    home.activation.setWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD /usr/bin/osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${wallpaper}\""
    '';
  };
}

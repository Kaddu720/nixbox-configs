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

  options.mac-desktop.enable = lib.mkEnableOption "Enable macOS desktop environment (Aerospace, etc.)";

  config = lib.mkIf config.mac-desktop.enable {
    aerospace.enable = true;
    
    # Set wallpaper
    home.activation.setWallpaper = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD /usr/bin/osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"${wallpaper}\""
    '';
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    thunar.enable =
      lib.mkEnableOption "enables thunar";
  };

  config = lib.mkIf config.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    services.gvfs.enable = true; # Mount, trash, and other functionalities
    services.tumbler.enable = true; # Thumbnail support for images
  };
}

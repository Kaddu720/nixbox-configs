{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    gtk-theme.enable =
      lib.mkEnableOption "enables gtk and gtk themes";
  };

  config = lib.mkIf config.gtk-theme.enable {
    gtk = {
      enable = true;
      cursorTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-cursor;
      };
      iconTheme = {
        name = "rose-pine";
        package = pkgs.rose-pine-icon-theme;
      };
    };
  };
}

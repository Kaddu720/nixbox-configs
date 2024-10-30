{lib, ...}:
with lib; {
  imports = [
    ./window-managers/aerospace.nix
    ./window-managers/dk.nix
    ./command-daemons/skhd.nix
    ./command-daemons/sxhkd.nix
  ];

  options.services.desktop-config = {
    enable = mkEnableOption "enables custom desktop module";

    linux = {
      dk = mkOption {
        type = types.bool;
        default = false;
        description = "Enable dk window manager for Linux";
      };
      sxhkd = mkOption {
        type = types.bool;
        default = false;
        description = "Enable sxhkd command daemon for Linux";
      };
    };

    mac = {
      aerospace = mkOption {
        type = types.bool;
        default = false;
        description = "Enable aerospace window manager for Mac";
      };
      skhd = mkOption {
        type = types.bool;
        default = false;
        description = "Enable skhd command daemon for Mac";
      };
    };
  };
}

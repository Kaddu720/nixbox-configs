{lib, ...}:
with lib; {
  imports = [
    ./window-managers/aerospace.nix
    ./window-managers/dk.nix
    ./window-managers/river.nix
    ./command-daemons/sxhkd.nix
    ./linux-utils
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
      river = mkOption {
        type = types.bool;
        default = false;
        description = "Enable river window manager for Linux";
      };
      linuxUtils = mkOption {
        type = types.bool;
        default = false;
        description = "Enable Utils for complete Linux desktop for Linux";
      };
    };

    mac = {
      aerospace = mkOption {
        type = types.bool;
        default = false;
        description = "Enable aerospace window manager for Mac";
      };
    };
  };
}

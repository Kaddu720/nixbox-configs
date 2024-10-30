{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.desktop;
in {
  imports = [
    ./window-managers/aerospace.nix
    ./window-managers/dk.nix
    ./command-daemons/skhd.nix
    ./command-daemons/sxhkd.nix
  ];

  options.services.desktop = {
    enable = mkEnableOption "enables custom desktop module";

    mac = mkOption {
      type = types.bool;
      default = false;
    };

    linux = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    # macOs
    aerospace.enable = mkIf (cfg.mac) true;
    skhd.enable = mkIf (cfg.mac) true;

    # linux
    dk.enable = mkIf (cfg.linux) true;
    sxhkd.enable = mkIf (cfg.linux) true;
  };
}

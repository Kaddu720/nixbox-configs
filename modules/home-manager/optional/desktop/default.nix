{lib, ...}:
with lib; {
  imports = [
    ./linux-desktop
    ./mac-desktop
  ];

  options.services.desktop-config = {
    enable = mkEnableOption "enables custom desktop module";

    linuxDesktop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable configuration for complete Linux desktop";
    };

    macDesktop = mkOption {
      type = types.bool;
      default = false;
      description = "Enable configuration for complete Mac desktop";
    };
  };
}

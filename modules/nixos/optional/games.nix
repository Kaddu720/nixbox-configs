{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    games.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.games.enable {
    # Hardware and drivers
    services.xserver.videoDrivers = ["amdgpu"];

    # Configure Environment
    environment = {
      # List packages at system level
      systemPackages = with pkgs; [
        mangohud
        protonup
        bottles
        piper
        libratbag
        lutris
        libadwaita # used by lutris
        wine64
        winetricks
        wineWowPackages.stable
        wineWowPackages.waylandFull
      ];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/noah/.steam/root/compatibilityrools.d";
      };
    };

    # Configure Programs
    programs = {
      corectrl = {
        enable = true;
        gpuOverclock.enable = true;
      };
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}

{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    steam.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.steam.enable {
    # Configure Environment
    environment = {
      # List packages at system level
      systemPackages = with pkgs; [
        mangohud
        protonup
      ];

      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/noah/.steam/root/compatibilityrools.d";
      };
    };

    # Configure Programs
    programs = {
      gamemode.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };
  };
}

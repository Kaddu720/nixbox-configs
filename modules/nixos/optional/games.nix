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
    # Configure Environment
    environment = {
      # List packages at system level
      systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          mangohud
          protonup
          bottles
          piper
          libratbag
          ;
      };

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

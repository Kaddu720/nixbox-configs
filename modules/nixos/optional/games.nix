{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {
    games.enable =
      lib.mkEnableOption "enables steam";
  };

  config = lib.mkIf config.games.enable {
    # Hardware and drivers
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
    services.xserver.videoDrivers = ["amdgpu"];

    # System Packages
    environment = {
      systemPackages = with pkgs; [
        bottles
        lutris
        libadwaita # used by lutris
        wine64
        winetricks
        wineWowPackages.stable
        wineWowPackages.waylandFull

        # Steam Specific
        protonup
        lact
        gamescope
        # gamescope-wsi
      ];
      sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/noah/.steam/root/compatibilityrools.d";
      };
    };

    systemd = {
      packages = with pkgs; [lact];
      services.lactd.wantedBy = ["multi-user.target"];
    };

    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        protontricks = {
          enable = true;
          package = pkgs.protontricks;
        };

        # PKGs needed for gamescope to work within steam
        package = pkgs.steam.override {
          extraPkgs = pkgs: (builtins.attrValues {
            inherit
              (pkgs.xorg)
              libXcursor
              libXi
              libXinerama
              libXScrnSaver
              ;

            inherit
              (pkgs.stdenv.cc.cc)
              lib
              ;

            inherit
              (pkgs)
              gamemode
              gperftools
              keyutils
              libkrb5
              libpng
              libpulseaudio
              libvorbis
              ;
          });
        };
        # extraCompatPackages = [ pkgs.unstable.proton-ge-bin ];
        gamescopeSession.enable = true;
      };

      gamemode = {
        enable = true;
        settings = {
          general = {
            softrealtime = "auto";
            inhibit_screensaver = 1;
            renice = 15;
          };
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 1; # The DRM device number on the system (usually 0), ie. the number in /sys/class/drm/card0/
            amd_performance_level = "high";
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
          };
        };
      };

      corectrl = {
        enable = true;
        gpuOverclock.enable = true;
      };
    };
  };
}

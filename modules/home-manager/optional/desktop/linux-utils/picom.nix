{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    picom.enable =
      lib.mkEnableOption "enables picom";
  };

  config = lib.mkIf config.picom.enable {
    home.packages = with pkgs; [picom];

    home.file = {
      ".config/picom/picom.conf".text = ''
        #################################
        #             Shadows           #
        #################################
        shadow = true;

        # The blur radius for shadows, in pixels. (defaults to 12)
        shadow-radius = 6

        # The opacity of shadows. (0.0 - 1.0, defaults to 0.75)
        shadow-opacity = .75

        # The left offset for shadows, in pixels. (defaults to -15)
        shadow-offset-x = -7;

        # The top offset for shadows, in pixels. (defaults to -15)
        shadow-offset-y = -7;

        shadow-exclude = [
          "class_g = 'rofi'"
        ]

        #################################
        #           Fading              #
        #################################
        # Fade windows in/out when opening/closing and when opacity changes,
        #  unless no-fading-openclose is used.
        fading = true;

        # Opacity change between steps while fading in. (0.01 - 1.0, defaults to 0.028)
        fade-in-step = 0.03;

        # Opacity change between steps while fading out. (0.01 - 1.0, defaults to 0.03)
        fade-out-step = 0.03;

        #################################
        #   Transparency / Opacity      #
        #################################
        # Opacity
        opacity-rule = [
            "85:class_g = 'Alacritty'",
            "75:class_g = 'discord'",
            "70:class_g = 'dwm'"
        ]

        #################################
        #           Corners             #
        #################################
        corner-radius = 10

        # Exclude conditions for rounded corners.
        rounded-corners-exclude = [
          "window_type = 'dock'",
          "window_type = 'desktop'",
          "class_g = 'dwm'",
        ];


        #################################
        #     Background-Blurring       #
        #################################
        blur:
        {
            blur-method = "dual_kawase"
            blur-size = 10
            blur-deviation = 15
            blur-background = true
            blur-strength = 10
        }


        # Exclude conditions for background blur.
        blur-background-exclude = [
          "window_type = 'desktop'",
          "_GTK_FRAME_EXTENTS@:c",
          "class_g ?= 'zoom'",
          "name = 'rofi'"
        ];


        #################################
        #       General Settings        #
        #################################
        backend = "glx";
        dithered-present = true;
        vsync = true;
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        #detect-client-opacity = true;
        detect-transient = true;
        use-damage = true;
        xrender-sync-fence = true;
        #log-level = "debug"
        log-level = "warn"
      '';
    };
  };
}

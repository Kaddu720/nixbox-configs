{
  pkgs,
  lib,
  config,
  vars,
  ...
}: let
  font-size =
    if ("${vars.hostName}" == "Work-Box" || "${vars.hostName}" == "Mobile-Box")
    then "18"
    else "12";
in {
  options = {
    ghostty.enable =
      lib.mkEnableOption "enables ghostty";
  };

  # Docs to read when I come back to fix this: https://github.com/kolunmi/ghostty
  config = lib.mkIf config.ghostty.enable {
    home.file.".config/ghostty/config" = {
      text = ''
        # Shell
        command = ${pkgs.fish}/bin/fish
        shell-integration = fish

        # Fonts
        font-size = ${font-size}

        # Padding
        window-padding-x = 10
        window-padding-y = 5

        # Hide title bars
        window-decoration = false
        gtk-tabs-location = hidden
        gtk-titlebar = false
        macos-titlebar-style = hidden

        #Themes
        theme = "reld"
        # Background Color
        background = #191724

        # Prompt
        cursor-style = block

        # Opacirty
        # background-opacity = 0.8
        # background-blur-radius = 20

        # Hid mouse while typing
        mouse-hide-while-typing = true
      '';
    };
    home.file.".config/ghostty/themes/reld" = {
      text = ''
        palette = 0=#191724
        palette = 1=#aa7264
        palette = 2=#bb5c3a
        palette = 3=#c78645
        palette = 4=#3b83aa
        palette = 5=#563ea9
        palette = 6=#3b83aa
        palette = 7=#c7c4c4
        palette = 8=#b4637a
        palette = 9=#aa7264
        palette = 10=#bb5c3a
        palette = 11=#c78645
        palette = 12=#3b83aa
        palette = 13=#3b83aa
        palette = 14=#563ea9
        palette = 15=#c7c4c4
        background = #191724
        foreground = #8c9aa5
        cursor-color = #c7c4c4
        cursor-text = #c7c4c4
        selection-background = #c7c4c4
        selection-foreground = #191724
      '';
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: let
  font-size =
    if "${config.home.username}" == "noahwilson"
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
  };
}

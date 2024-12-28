{
  pkgs,
  lib,
  config,
  ...
}: {
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

        # Fonts
        font-family = "JetBrainsMono Nerd Font Mono"
        font-family-bold = "JetBrainsMono NFM Bold"
        font-family-italic = "JetBrainsMono NFM Italic"
        font-family-bold-italic = "JetBrainsMono NFM Bold Italic"
        font-size = 12

        # Padding
        window-padding-x = 10
        window-padding-y = 5

        # Hide title bars
        window-decoration = false
        gtk-tabs-location = hidden
        macos-titlebar-style = hidden

        # Opacirty
        background-opacity = 0.8
        background-blur-radius = 20
      '';
    };
  };
}

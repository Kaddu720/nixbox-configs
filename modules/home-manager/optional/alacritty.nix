{
  pkgs,
  lib,
  config,
  vars,
  ...
}: let
  font-size =
    if ("${vars.hostName}" == "Home-Box")
    then 12
    else 18;
in {
  options = {
    alacritty.enable =
      lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable (let
    alacritty-config = pkgs.writeText "alacritty-config" ''
        [env]
        TERM = "xterm-256color"

        [terminal.shell]
        program = "fish"
        args = []

        [window]
        padding.x = 10
        padding.y = 5
        dynamic_padding = true
        decorations = "None"
        opacity = 1.0

        [colors.primary]
        background = "#191724"
        foreground = "#8c9aa5"

        [colors.cursor]
        text = "#c7c4c4"
        cursor = "#c7c4c4"

        [colors.selection]
        text = "#191724"
        background = "#c7c4c4"

        [colors.normal]
        black = "#191724"
        red = "#b4637a"
        green = "#bb5c3a"
        yellow = "#c78645"
        blue = "#3b83aa"
        magenta = "#563ea9"
        cyan = "#3b83aa"
        white = "#c7c4c4"

        [colors.bright]
        black = "#aa7264"
        red = "#aa7264"
        green = "#bb5c3a"
        yellow = "#c78645"
        blue = "#3b83aa"
        magenta = "#3b83aa"
        cyan = "#563ea9"
        white = "#c7c4c4"

        [font]
        size = ${toString font-size}

        [cursor]
        style = "Block"
        unfocused_hollow = true

        [scrolling]
        history = 10000
        multiplier = 3

        [mouse]
        hide_when_typing = true

        [keyboard]
        bindings = [
          { key = "V", mods = "Control|Shift", action = "Paste" },
          { key = "C", mods = "Control|Shift", action = "Copy" },
          { key = "Plus", mods = "Control", action = "IncreaseFontSize" },
          { key = "Minus", mods = "Control", action = "DecreaseFontSize" },
          { key = "Key0", mods = "Control", action = "ResetFontSize" }
        ]
      '';
  in {
    home.packages = with pkgs; [alacritty];
    
    xdg.configFile."alacritty/alacritty.toml".source = "${alacritty-config}";
  });
}

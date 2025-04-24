{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alacritty.enable =
      lib.mkEnableOption "enables alacritty";
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        terminal.shell = {
          program = "${pkgs.fish}/bin/fish";
        };
        env = {
          term = "xterm-256color";
        };

        window = {
          padding = {
            x = 10;
            y = 5;
          };
          dynamic_padding = true;
          decorations = "Buttonless";
        };
      };
    };
  };
}

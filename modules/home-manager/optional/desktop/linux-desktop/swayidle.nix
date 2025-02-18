{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    swayidle.enable =
      lib.mkEnableOption "enables swayidle";
  };

  # Docs to read when I come back to fix this: https://github.com/kolunmi/swayidle
  config = lib.mkIf config.swayidle.enable {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 300;
          command = "~/.config/scripts/lockscreen.sh";
        }
        # {
        #   timeout = 360;
        #   command = "${pkgs.systemd}/bin/systemctl suspend";
        # }
      ];
    };
  };
}

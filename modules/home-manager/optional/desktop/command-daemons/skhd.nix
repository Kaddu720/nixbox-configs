{
  lib,
  config,
  ...
}: {
  config = lib.mkIf (config.services.desktop-config.mac.skhd == true) {
    home.file.".config/skhd/skhdrc" = {
      text = ''
        # open terminal
        alt - return : alacritty

        # open brower
        alt - w : open -n -a "Zen Browser"
      '';
      executable = true;
    };
  };
}

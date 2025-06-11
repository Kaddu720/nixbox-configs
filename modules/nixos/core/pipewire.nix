{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    pipewire.enable =
      lib.mkEnableOption "enables pipewire";
  };

  config = lib.mkIf config.pipewire.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

  };
}

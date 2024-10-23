{
  lib,
  config,
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
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };
}

{
  lib,
  config,
  ...
}: {
  options = {
    starship.enable =
      lib.mkEnableOption "enables starship shell";
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
    };
  };
}

{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dev-cloud.enable =
      lib.mkEnableOption "enables cloud/infrastructure tools";
  };

  config = lib.mkIf config.dev-cloud.enable {
    home.packages = with pkgs; [
      awscli2
      terraform
      opentofu
    ];
  };
}

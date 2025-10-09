{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dev-containers.enable =
      lib.mkEnableOption "enables container development tools";
  };

  config = lib.mkIf config.dev-containers.enable {
    home.packages = with pkgs; [
      podman
      docker
      lazydocker
    ];
  };
}

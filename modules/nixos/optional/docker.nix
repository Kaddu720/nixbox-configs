{
  config,
  lib,
  ...
}: {
  options = {
    docker.enable =
      lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.docker.enable {
    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
      liveRestore = false;
    };
  };
}

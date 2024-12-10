{
  config,
  lib,
pkgs,
  ...
}: {
  options = {
    docker.enable =
      lib.mkEnableOption "enables docker";
  };

  config = lib.mkIf config.docker.enable {
    environment.systemPackages = with pkgs; [
    ];

    virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };
}

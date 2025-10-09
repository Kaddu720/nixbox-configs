{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dev-kubernetes.enable =
      lib.mkEnableOption "enables kubernetes development tools";
  };

  config = lib.mkIf config.dev-kubernetes.enable {
    home.packages = with pkgs; [
      kubectl
      kubectx
      k9s
      lens
    ];
  };
}

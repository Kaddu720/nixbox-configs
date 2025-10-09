{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    dev-ai.enable =
      lib.mkEnableOption "enables AI development tools";
  };

  config = lib.mkIf config.dev-ai.enable {
    home.packages = with pkgs; [
      ollama
      # lmstudio
    ];
  };
}

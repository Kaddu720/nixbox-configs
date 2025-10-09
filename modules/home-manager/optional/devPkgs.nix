{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    devPkgs.enable =
      lib.mkEnableOption "enables core development packages";
  };

  config = lib.mkIf config.devPkgs.enable {
    home.packages = with pkgs; [
      lazygit
      jq
      nerd-fonts.jetbrains-mono
      warp-terminal
      circumflex
      opencode
    ];

    programs = {
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  };
}

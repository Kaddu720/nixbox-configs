{
  lib,
  config,
  ...
}: {
  options = {
    git.enable =
      lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;
      settings = {
        pull.rebase = true;
        core.editor = "nvim";
        user = {
          name = "Kaddu720";
          email = "nwilsonmalgus@gmail.com";
        };
      };
    };
  };
}

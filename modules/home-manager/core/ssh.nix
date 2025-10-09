{
  lib,
  config,
  ...
}: {
  options = {
    ssh = {
      enable = lib.mkEnableOption "enables ssh";
      githubIdentityFile = lib.mkOption {
        type = lib.types.str;
        description = "SSH key path for GitHub authentication";
      };
    };
  };

  config = lib.mkIf config.ssh.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      extraOptionOverrides = {
        SetEnv = "TERM=xterm";
      };
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
        };
        "github.com" = {
          user = "git";
          identityFile = config.ssh.githubIdentityFile;
        };
      };
    };
  };
}

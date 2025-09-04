{
  lib,
  config,
  vars,
  ...
}: {
  options = {
    ssh.enable =
      lib.mkEnableOption "enables ssh";
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
          identityFile = "${vars.sshKey}";
        };
      };
    };
  };
}

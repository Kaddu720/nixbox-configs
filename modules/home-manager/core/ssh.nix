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
      addKeysToAgent = "yes";
      extraOptionOverrides = {
        SetEnv = "TERM=xterm";
      };
      matchBlocks = {
        "github.com" = {
          user = "git";
          identityFile = "${vars.sshKey}";
        };
      };
    };
  };
}
